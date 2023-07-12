import sys
from PyQt5.QtWidgets import QApplication, QMainWindow, QLabel, QLineEdit, QPushButton, QMessageBox, QInputDialog, \
    QFileDialog
from PyQt5.QtGui import QPixmap
from PyQt5.QtCore import Qt
import pymysql
import face_recognition
import cv2
import os
from window_trash import TrashClassificationWindow
from AdminUI import AdminWindow
# from test import TrashClassificationWindow1
class LoginWindow(QMainWindow):
    def __init__(self):
        super().__init__()

        self.setWindowTitle("登录界面")
        self.setGeometry(100, 100, 300, 240)

        self.login_label = QLabel("登录", self)
        self.login_label.setAlignment(Qt.AlignCenter)
        self.login_label.setGeometry(50, 20, 200, 40)

        self.username_label = QLabel("用户名:", self)
        self.username_label.setGeometry(30, 70, 80, 20)

        self.username_input = QLineEdit(self)
        self.username_input.setGeometry(110, 70, 150, 20)

        self.password_label = QLabel("密码:", self)
        self.password_label.setGeometry(30, 100, 80, 20)

        self.password_input = QLineEdit(self)
        self.password_input.setGeometry(110, 100, 150, 20)
        self.password_input.setEchoMode(QLineEdit.Password)

        self.login_button = QPushButton("登录", self)
        self.login_button.setGeometry(40, 140, 100, 30)
        self.login_button.clicked.connect(self.check_login)

        self.register_user_button = QPushButton("用户注册", self)
        self.register_user_button.setGeometry(160, 140, 100, 30)
        self.register_user_button.clicked.connect(self.register_user)

        self.register_admin_button = QPushButton("管理员注册", self)
        self.register_admin_button.setGeometry(40, 180, 220, 30)
        self.register_admin_button.clicked.connect(self.register_admin)

        self.admin_face_encoding = None

        self.conn = None

    def connect_db(self):
        try:
            self.conn = pymysql.connect(host='localhost', user='root', password='123456', db='userdb', charset='utf8mb4')
            return True
        except pymysql.Error as e:
            print("数据库连接失败：", e)
            return False

    def closeEvent(self, event):
        if self.conn:
            self.conn.close()

    def check_login(self):
        username = self.username_input.text()
        password = self.password_input.text()

        if self.authenticate_user(username, password):
            QMessageBox.information(self, "登录成功", "欢迎使用垃圾分类系统！")
            if "admin" in username:
                self.admin_window = AdminWindow()
                self.admin_window.show()
                self.close()
            elif 'user' in username:
                self.trash_classification_window = TrashClassificationWindow()
                self.trash_classification_window.show()
                self.close()
            # 进入系统主界面
            main_window = MainWindow(username)
            main_window.show()
        else:
            QMessageBox.warning(self, "登录失败", "用户名或密码错误！")

    def authenticate_user(self, username, password):
        if not self.conn:
            QMessageBox.warning(self, "登录失败", "数据库连接失败！")
            return False

        try:
            with self.conn.cursor() as cursor:
                sql = "SELECT * FROM user WHERE username=%s AND password=%s"
                cursor.execute(sql, (username, password))
                user = cursor.fetchone()

            if user:
                return True
            with self.conn.cursor() as cursor:
                sql = "SELECT * FROM admin WHERE username=%s AND password=%s"
                cursor.execute(sql, (username, password))
                admin = cursor.fetchone()

            if admin:
                return True

            return False
        except pymysql.Error as e:
            print("查询用户失败：", e)
            return False

    def register_user(self):
        username, ok = QInputDialog.getText(self, "用户注册", "请输入用户名:")
        if ok:
            password, ok = QInputDialog.getText(self, "用户注册", "请输入密码:", QLineEdit.Password)
            if ok:
                if not self.conn:
                    QMessageBox.warning(self, "注册失败", "数据库连接失败！")
                    return
                try:
                    with self.conn.cursor() as cursor:
                        # 查询数据库中是否已存在相同用户名
                        sql_query = "SELECT * FROM user WHERE username=%s"
                        cursor.execute(sql_query, (username,))
                        result = cursor.fetchone()
                        if result:  # 用户名已存在
                            QMessageBox.warning(self, "注册失败", "用户名已存在，请重新注册！")
                            return

                        # 插入新用户信息
                        sql_insert = "INSERT INTO user (username, password) VALUES (%s, %s)"
                        cursor.execute(sql_insert, (username, password))
                        self.conn.commit()
                    QMessageBox.information(self, "注册成功", "用户注册成功！")
                except pymysql.Error as e:
                    print("用户注册失败：", e)
                    QMessageBox.warning(self, "注册失败", "用户注册失败，请重试！")

    def capture_face(self):
        # 打开摄像头
        cap = cv2.VideoCapture(0)
        while True:
            ret, frame = cap.read()
            # 显示摄像头捕获的图像
            cv2.imshow('Capture Face', frame)
            # 按下空格键拍摄照片
            if cv2.waitKey(1) & 0xFF == ord(' '):
                # 保存照片到文件
                cv2.imwrite('captured_face.jpg', frame)
                break
        # 关闭摄像头和窗口
        cap.release()
        cv2.destroyAllWindows()
        self.compare_face()

    def register_admin(self):
        # 捕获人脸图像
        cap = cv2.VideoCapture(0)

        while True:
            ret, frame = cap.read()

            # 显示摄像头捕获的图像
            cv2.imshow('Capture Face', frame)

            # 按下空格键拍摄照片
            if cv2.waitKey(1) & 0xFF == ord(' '):
                # 保存照片到文件
                cv2.imwrite('registered_face.jpg', frame)
                break

        # 关闭摄像头和窗口
        cap.release()
        cv2.destroyAllWindows()

        # 加载管理员的人脸照片
        admin_image = face_recognition.load_image_file("D:/pycharm/OpenCv/face/person_1_hjl/img_face_2.jpg")
        admin_face_encoding = face_recognition.face_encodings(admin_image)[0]

        # 加载刚刚捕获的人脸照片
        registered_image = face_recognition.load_image_file('registered_face.jpg')
        registered_face_encoding = face_recognition.face_encodings(registered_image)[0]

        # 对比两张人脸照片
        results = face_recognition.compare_faces([admin_face_encoding], registered_face_encoding)

        if results[0]:
            QMessageBox.information(self, "人脸识别成功", "人脸识别通过，请继续注册！")

            # 获取管理员注册信息
            username, ok = QInputDialog.getText(self, "管理员注册", "请输入用户名:")
            if ok and username:
                password, ok = QInputDialog.getText(self, "管理员注册", "请输入密码:", QLineEdit.Password)
                if ok and password:
                    # 进行管理员注册的逻辑
                    if not self.conn:
                        QMessageBox.warning(self, "注册失败", "数据库连接失败！")
                        return
                    try:
                        with self.conn.cursor() as cursor:
                            # 查询数据库中是否已存在相同用户名
                            sql_query = "SELECT * FROM admin WHERE username=%s"
                            cursor.execute(sql_query, (username,))
                            result = cursor.fetchone()
                            if result:  # 用户名已存在
                                QMessageBox.warning(self, "注册失败", "用户名已存在，请重新注册！")
                                return

                            # 插入新管理员信息
                            sql_insert = "INSERT INTO admin (username, password) VALUES (%s, %s)"
                            cursor.execute(sql_insert, (username, password))
                            self.conn.commit()
                        QMessageBox.information(self, "注册成功", "管理员注册成功！")
                        # 注册成功后，删除捕获的照片文件
                        if os.path.exists('registered_face.jpg'):
                            os.remove('registered_face.jpg')
                    except pymysql.Error as e:
                        print("管理员注册失败：", e)
                        QMessageBox.warning(self, "注册失败", "管理员注册失败，请重试！")
                else:
                    QMessageBox.warning(self, "注册失败", "密码不能为空！")
            else:
                QMessageBox.warning(self, "注册失败", "用户名不能为空！")
        else:
            QMessageBox.warning(self, "人脸识别失败", "人脸识别未通过，请重新捕获人脸图像！")


class MainWindow(QMainWindow):
    def __init__(self, username):
        super().__init__()

        self.setWindowTitle("垃圾分类系统")
        self.setGeometry(100, 100, 800, 600)

        self.username = username

        self.welcome_label = QLabel(f"欢迎回来，{self.username}！", self)
        self.welcome_label.setAlignment(Qt.AlignCenter)
        self.welcome_label.setGeometry(50, 50, 700, 40)

        self.logout_button = QPushButton("退出登录", self)
        self.logout_button.setGeometry(650, 50, 100, 30)
        self.logout_button.clicked.connect(self.logout)

    def logout(self):
        reply = QMessageBox.question(self, "确认退出", "确定要退出登录吗？",
                                     QMessageBox.Yes | QMessageBox.No, QMessageBox.No)
        if reply == QMessageBox.Yes:
            self.close()
            # 返回登录界面
            login_window = LoginWindow()
            login_window.show()


if __name__ == "__main__":
    app = QApplication(sys.argv)
    login_window = LoginWindow()
    valid_db_conn = login_window.connect_db()
    if not valid_db_conn:
        sys.exit(-1)
    login_window.show()
    sys.exit(app.exec_())