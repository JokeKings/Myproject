# -*- coding: UTF-8 –*-
from PyQt5.QtWidgets import QMainWindow, QLabel, QTextEdit, QPushButton, QComboBox, QMessageBox, QApplication, \
    QVBoxLayout, QDialog, QInputDialog, QLineEdit
from PyQt5.QtGui import QImage, QPixmap
from PyQt5.QtCore import Qt
import cv2
import face_recognition
import pymysql
import os

class AdminWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.view_admins_button = QPushButton("查看管理员", self)
        self.view_admins_button.setGeometry(580, 240, 200, 50)
        self.view_admins_button.clicked.connect(self.view_admins)

        self.view_users_button = QPushButton("查看用户", self)
        self.view_users_button.setGeometry(580, 320, 200, 50)
        self.view_users_button.clicked.connect(self.view_users)

        self.setWindowTitle("管理员界面")
        self.setGeometry(100, 100, 800, 600)

        self.feedback_label = QLabel("用户反馈", self)
        self.feedback_label.setGeometry(50, 50, 200, 20)

        self.feedback_text = QTextEdit(self)
        self.feedback_text.setGeometry(50, 80, 500, 200)

        self.delete_admin_button = QPushButton("删除管理员", self)
        self.delete_admin_button.setGeometry(580, 320, 200, 50)
        self.delete_admin_button.clicked.connect(self.verify_delete_admin)

        self.delete_user_button = QPushButton("删除用户", self)
        self.delete_user_button.setGeometry(580, 400, 200, 50)
        self.delete_user_button.clicked.connect(self.verify_delete_user)

        self.view_feedback_button = QPushButton("查看用户反馈", self)
        self.view_feedback_button.setGeometry(580, 80,200, 50)
        self.view_feedback_button.clicked.connect(self.view_feedback)

        self.delete_feedback_button = QPushButton("删除用户反馈", self)
        self.delete_feedback_button.setGeometry(580, 160, 200, 50)
        self.delete_feedback_button.clicked.connect(self.verify_delete_feedback)

        self.username_label = QLabel("用户名:", self)
        self.username_label.setGeometry(50, 300, 80, 20)

        self.user_selection = QComboBox(self)
        self.user_selection.setGeometry(140, 300,150, 50)

        self.search_user_button = QPushButton("查询用户", self)
        self.search_user_button.setGeometry(320, 300, 200, 50)
        self.search_user_button.clicked.connect(self.search_user)

        self.modify_password_button = QPushButton("修改密码", self)
        self.modify_password_button.setGeometry(580, 240, 200, 50)
        self.modify_password_button.clicked.connect(self.verify_face_for_modify_password)

        # 创建数据库连接
        self.connection = pymysql.connect(host="localhost", user="root", password="123456", database="userdb")
        self.cursor = self.connection.cursor()

        self.admin_face_encoding = None

        self.populate_user_selection()  # 填充用户选择框

    def view_feedback(self):
        try:
            # 检查文件是否存在
            file_path = "result.txt"
            if os.path.exists(file_path):
                # 读取用户反馈信息
                with open(file_path, "r", encoding="utf-8") as file:
                    feedback = file.read()
                self.feedback_text.setText(feedback)
            else:
                QMessageBox.warning(self, "文件不存在", "用户反馈文件不存在！")
        except Exception as e:
            print(f"读取用户反馈时发生错误：{str(e)}")
            QMessageBox.warning(self, "错误", f"读取用户反馈时发生错误：{str(e)}")

    def delete_feedback(self):
        # 删除文件中的用户反馈内容
        with open("result.txt", "w", encoding="utf-8") as file:
            file.write("")
        self.feedback_text.setText("")
        QMessageBox.information(self, "删除成功", "用户反馈已成功删除！")

    def verify_delete_feedback(self):
        results = self.compare_face()
        if results[0]:
            reply = QMessageBox.question(self, "删除确认", "确定要删除用户反馈吗？", QMessageBox.Yes | QMessageBox.No, QMessageBox.No)
            if reply == QMessageBox.Yes:
                self.delete_feedback()
        else:
            QMessageBox.warning(self, "人脸识别失败", "人脸识别未通过，请重新进行人脸验证！")

    def view_admins(self):
        # 查询所有管理员信息
        sql = "SELECT username FROM user WHERE username != 'admin' AND is_admin = 1"
        self.cursor.execute(sql)
        admins = self.cursor.fetchall()
        admin_info = "管理员列表：\n"
        for admin in admins:
            admin_info += f"用户名：{admin[0]}\n"
        QMessageBox.information(self, "管理员信息", admin_info)

    def view_users(self):
        # 查询所有用户信息
        sql = "SELECT username FROM user WHERE is_admin = 0"
        self.cursor.execute(sql)
        users = self.cursor.fetchall()
        user_info = "用户列表：\n"
        for user in users:
            user_info += f"用户名：{user[0]}\n"
        QMessageBox.information(self, "用户信息", user_info)

    def search_user(self):
        username = self.user_selection.currentText()  # 获取选择的用户名
        # 查询用户信息
        sql = "SELECT * FROM user WHERE username=%s"
        self.cursor.execute(sql, (username,))
        user = self.cursor.fetchone()
        if user:
            user_info = f"用户名：{user[0]}\n账号密码：{user[1]}\n"
            QMessageBox.information(self, "用户信息", user_info)
            self.feedback_text.setText(user_info)  # 更新界面的文本框内容
        else:
            QMessageBox.warning(self, "用户不存在", "输入的用户名不存在！")

    def verify_face_for_modify_password(self):
        reply = QMessageBox.question(self, '人脸识别确认', '请将人脸置于摄像头前并对准人脸识别器，然后点击“确定”按钮开始人脸识别验证。',
                                     QMessageBox.Ok | QMessageBox.Cancel, QMessageBox.Ok)
        if reply == QMessageBox.Ok:
            self.face_recognition_dialog = FaceRecognitionDialog(self)
            self.face_recognition_dialog.exec_()
            if self.face_recognition_dialog.verified:
                self.modify_password()
            else:
                QMessageBox.warning(self, "人脸识别失败", "人脸识别未通过，请重新进行人脸验证！")

    def modify_password(self):
        username, ok_pressed = QInputDialog.getText(self, "输入用户名", "请输入要修改密码的用户名:")
        if ok_pressed:
            new_password, ok_pressed = QInputDialog.getText(self, "输入新密码", "请输入新的密码:")
            if ok_pressed:
                # 查询用户信息
                sql = "SELECT * FROM user WHERE username=%s"
                self.cursor.execute(sql, (username,))
                user = self.cursor.fetchone()
                if user:
                    # 修改选定用户的密码
                    sql = "UPDATE user SET password=%s WHERE username=%s"
                    self.cursor.execute(sql, (new_password, username))
                    self.connection.commit()

                    QMessageBox.information(self, "修改成功", "用户密码已成功修改！")
                    # self.close()  # 退出界面
                else:
                    QMessageBox.warning(self, "用户不存在", "输入的用户名不存在！")

    def populate_user_selection(self):
        # 从数据库中获取用户名，并添加到QComboBox
        sql = "SELECT username FROM user"
        self.cursor.execute(sql)
        usernames = self.cursor.fetchall()
        for username in usernames:
            self.user_selection.addItem(username[0])

    def verify_delete_admin(self):
        username, ok_pressed = QInputDialog.getText(self, "删除管理员", "请输入要删除的管理员用户名:")
        if ok_pressed:
            if username == "admin":
                QMessageBox.warning(self, "删除失败", "不能删除管理员账号！")
            else:
                reply = QMessageBox.question(self, "删除确认", f"确定要删除管理员 {username} 吗？",
                                             QMessageBox.Yes | QMessageBox.No, QMessageBox.No)
                if reply == QMessageBox.Yes:
                    # 删除指定用户名的用户
                    sql = "DELETE FROM admin WHERE username=%s"
                    self.cursor.execute(sql, (username,))
                    self.connection.commit()
                    self.delete_user(username)

    def verify_delete_user(self):
        username, ok_pressed = QInputDialog.getText(self, "删除用户", "请输入要删除的用户用户名:")
        if ok_pressed:
            reply = QMessageBox.question(self, "删除确认", f"确定要删除用户 {username} 吗？",
                                         QMessageBox.Yes | QMessageBox.No, QMessageBox.No)
            if reply == QMessageBox.Yes:
                self.delete_user(username)

    def delete_user(self, username):
        # 删除指定用户名的用户
        sql = "DELETE FROM user WHERE username=%s"
        self.cursor.execute(sql, (username,))
        self.connection.commit()

        QMessageBox.information(self, "删除成功", f"用户 {username} 已成功删除！")






    def compare_face(self):
        # 加载管理员照片并进行人脸编码
        admin_image = face_recognition.load_image_file("D:/pycharm/OpenCv/face/person_1_hjl/img_face_2.jpg")
        admin_face_encoding = face_recognition.face_encodings(admin_image)[0]

        # 打开摄像头进行人脸识别
        camera = cv2.VideoCapture(0)
        while True:
            ret, frame = camera.read()
            if ret:
                rgb_frame = frame[:, :, ::-1]
                face_locations = face_recognition.face_locations(rgb_frame)
                face_encodings = face_recognition.face_encodings(rgb_frame, face_locations)

                for (top, right, bottom, left), face_encoding in zip(face_locations, face_encodings):
                    # 与管理员照片进行对比
                    matches = face_recognition.compare_faces([admin_face_encoding], face_encoding)
                    if True in matches:
                        return True, None  # 人脸匹配成功

                cv2.imshow('Face Recognition', frame)
                if cv2.waitKey(1) & 0xFF == ord('q'):
                    break

        camera.release()
        cv2.destroyAllWindows()

        return False, None


class FaceRecognitionDialog(QDialog):
    def __init__(self, parent=None):
        super().__init__(parent)
        self.setWindowTitle("人脸识别")
        self.setFixedSize(240, 320)  # 设置窗口大小

        layout = QVBoxLayout(self)
        self.camera_label = QLabel(self)
        layout.addWidget(self.camera_label)

        self.face_cascade = cv2.CascadeClassifier("D:\opencv\sources\data\haarcascades\haarcascade_frontalface_default.xml")
        self.verified = False

        self.start_recognition()

    def start_recognition(self):
        # 加载指定图片进行人脸编码
        admin_image = face_recognition.load_image_file("D:/pycharm/OpenCv/face/person_1_hjl/img_face_2.jpg")
        admin_face_encoding = face_recognition.face_encodings(admin_image)[0]

        # 打开摄像头并进行人脸识别
        camera = cv2.VideoCapture(0)
        camera.set(cv2.CAP_PROP_FPS, 10)  # 设置帧率为10帧/秒
        while True:
            ret, frame = camera.read()
            if ret:
                gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
                faces = self.face_cascade.detectMultiScale(gray, scaleFactor=1.3, minNeighbors=5, minSize=(30, 30))
                for (x, y, w, h) in faces:
                    cv2.rectangle(frame, (x, y), (x + w, y + h), (0, 255, 0), 2)

                    # 与指定图片进行对比
                    face_locations = [(y, x + w, y + h, x)]
                    face_encodings = face_recognition.face_encodings(frame, face_locations)
                    matches = face_recognition.compare_faces([admin_face_encoding], face_encodings[0])

                    if True in matches:
                        self.verified = True
                        break

                image_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
                height, width, channel = image_rgb.shape
                qimage = QImage(image_rgb.data, width, height, channel * width, QImage.Format_RGB888)
                scaled_qimage = qimage.scaled(240, 320, Qt.KeepAspectRatio)  # 缩放图片
                self.camera_label.setPixmap(QPixmap.fromImage(scaled_qimage))
                QApplication.processEvents()

                if self.verified:
                    break

            if cv2.waitKey(1) == ord('q'):
                break

        camera.release()
        cv2.destroyAllWindows()

        if self.verified:
            QMessageBox.information(self, "人脸识别成功", "人脸识别通过！")
        else:
            QMessageBox.warning(self, "人脸识别失败", "人脸识别未通过！")
        self.close()
import sys
if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = AdminWindow()
    window.show()
    sys.exit(app.exec_())