# -*- coding: UTF-8 –*-
import tensorflow as tf
from PyQt5.QtGui import *
from PyQt5.QtCore import *
from PyQt5.QtWidgets import *
import sys
import cv2
from PIL import Image
import numpy as np
import shutil


class TrashClassificationWindow(QTabWidget):
    def __init__(self):
        super().__init__()
        self.setWindowIcon(QIcon('images/logo.png'))
        self.setWindowTitle('垃圾智能分类系统')
        self.model = tf.keras.models.load_model("D:/pycharm/OpenCv/项目/实习项目/trash_classification_tf2.3-master/models/cnn_245_epoch30.h5")  # todo 修改为自己的模型路径
        print("模型加载成功!!!")
        self.to_predict_name = "images/cc.jpeg"
        self.class_names={0: "硬纸板", 1: "玻璃", 2: "金属", 3: "纸", 4: "塑料", 5: "有害"}
        self.resize(900, 700)
        self.right_layout = QVBoxLayout()
        self.initUI()

    def initUI(self):
        layout = QVBoxLayout()
        main_widget = QWidget()
        main_layout = QHBoxLayout()
        font = QFont('楷体', 15)
        left_widget = QWidget()
        left_layout = QVBoxLayout()
        img_title = QLabel("样本")
        img_title.setFont(font)
        img_title.setAlignment(Qt.AlignCenter)
        self.img_label = QLabel()
        img_init = cv2.imread(self.to_predict_name)
        h, w, c = img_init.shape
        scale = 400 / h
        img_show = cv2.resize(img_init, (0, 0), fx=scale, fy=scale)
        cv2.imwrite("images/show.png", img_show)
        img_init = cv2.resize(img_init, (224, 224))
        cv2.imwrite('images/target.png', img_init)
        self.img_label.setPixmap(QPixmap("images/show.png"))
        left_layout.addWidget(img_title)
        left_layout.addWidget(self.img_label, 1, Qt.AlignCenter)
        # left_layout.setAlignment(Qt.AlignCenter)
        left_widget.setLayout(left_layout)
        right_widget = QWidget()
        right_layout = QVBoxLayout()
        btn_change = QPushButton(" 上传图片 ")
        btn_change.clicked.connect(self.change_img)
        btn_change.setFont(font)
        btn_predict = QPushButton(" 开始识别 ")
        btn_predict.setFont(font)
        btn_predict.clicked.connect(self.predict_img)
        btn_feedback = QPushButton("反馈和评价")  # 添加反馈按钮
        btn_feedback.setFont(font)
        btn_feedback.clicked.connect(self.feedback)
        label_result = QLabel(' 垃圾种类 ')
        self.result = QLabel("等待识别")
        label_result.setFont(QFont('楷体', 16))
        self.result.setFont(QFont('楷体', 24))

        label_result_f = QLabel(' 物品名称 ')
        self.result_f = QLabel("等待识别")

        self.label_info = QTextEdit()
        self.label_info.setFont(QFont('楷体', 12))

        label_result_f.setFont(QFont('楷体', 16))
        self.result_f.setFont(QFont('楷体', 24))

        right_layout.addStretch()
        right_layout.addWidget(label_result, 0, Qt.AlignCenter)

        right_layout.addStretch()
        right_layout.addWidget(self.result, 0, Qt.AlignCenter)

        right_layout.addStretch()
        right_layout.addWidget(label_result_f, 0, Qt.AlignCenter)

        right_layout.addStretch()
        right_layout.addWidget(self.result_f, 0, Qt.AlignCenter)

        right_layout.addStretch()
        right_layout.addWidget(self.label_info, 0, Qt.AlignCenter)
        right_layout.addStretch()
        right_layout.addWidget(btn_change)
        right_layout.addWidget(btn_predict)
        right_layout.addWidget(btn_feedback)
        right_layout.addStretch()
        right_widget.setLayout(right_layout)

        # 关于页面
        about_widget = QWidget()
        about_layout = QVBoxLayout()
        about_title = QLabel('欢迎使用垃圾分类系统')
        about_title.setFont(QFont('楷体', 18))
        about_title.setAlignment(Qt.AlignCenter)
        about_img = QLabel()
        about_img.setPixmap(QPixmap('images/about.png'))
        about_img.setAlignment(Qt.AlignCenter)
        label_super = QLabel('<a href="Joke">作者：Joke</a>')
        label_super.setFont(QFont('楷体', 12))
        label_super.setOpenExternalLinks(True)
        label_super.setAlignment(Qt.AlignRight)
        about_layout.addWidget(about_title)
        about_layout.addStretch()
        about_layout.addWidget(about_img)
        about_layout.addStretch()
        about_layout.addWidget(label_super)
        about_widget.setLayout(about_layout)

        main_layout.addWidget(left_widget)
        main_layout.addWidget(right_widget)
        main_widget.setLayout(main_layout)
        self.addTab(main_widget, '主页')
        self.addTab(about_widget, '关于')
        self.setTabIcon(0, QIcon('images/主页面.png'))
        self.setTabIcon(1, QIcon('images/关于.png'))

    def feedback(self):
        text, ok = QInputDialog.getText(self, '反馈和评价', '请输入您的反馈和评价：')
        if ok:
            with open("result.txt", "a", encoding="utf-8") as f:
                f.write(text + '\n')
            QMessageBox.information(self, '提示', '感谢您的反馈和评价！')

    # 上传图片
    def change_img(self):
        openfile_name = QFileDialog.getOpenFileName(self, 'chose files', '', 'Image files(*.jpg *.png *jpeg)')
        img_name = openfile_name[0]
        if img_name == '':
            pass
        else:
            target_image_name = "images/tmp_single" + img_name.split(".")[-1]
            shutil.copy(img_name, target_image_name)
            self.to_predict_name = target_image_name
            img_init = cv2.imread(self.to_predict_name)
            h, w, c = img_init.shape
            scale = 400 / h
            img_show = cv2.resize(img_init, (0, 0), fx=scale, fy=scale)
            cv2.imwrite("images/show.png", img_show)
            img_init = cv2.resize(img_init, (224, 224))
            cv2.imwrite('images/target.png', img_init)
            self.img_label.setPixmap(QPixmap("images/show.png"))

    # 预测图片
    def predict_img(self):
        try:

            img = Image.open('images/target.png')
            print("开始识别")
            img = np.asarray(img)
            outputs = self.model.predict(img.reshape(1, 224, 224, 3))
            result_index = int(np.argmax(outputs))
            result = self.class_names[result_index]
            print("预测结果:", result)
            result_index = int(np.argmax(outputs))
            result = self.class_names[result_index]
            names = result.split("_")
            print(names)


            if names[0] == "湿垃圾":
                self.label_info.setText(
                    "湿垃圾容易腐烂产生恶臭和细菌，对环境和人体健康造成危害。不正确处理湿垃圾可能导致水体污染，包括丢弃不用的菜叶、剩菜、剩饭、果皮、蛋壳、茶渣、骨头等。由于厨余垃圾含有极高的水分与有机物，很容易腐坏，产生恶臭。经过妥善处理和加工，可转化为新的资源，高有机物含量的特点使其经过严格处理后可作为肥料、饲料，也可产生沼气用作燃料或发电，油脂部分则可用于制备生物燃料。")
            if names[0] == "有害垃圾":
                self.label_info.setText(
                    "有害垃圾指对人体健康或者自然环境造成直接或者潜在危害的生活废弃物。常见的有害垃圾包括废灯管、废油漆、杀虫剂、废弃化妆品、过期药品、废电池、废灯泡、废水银温度计等，有害垃圾需按照特殊正确的方法安全处理，一般需要经过特殊的处理之后才可以进行焚烧，堆肥，填埋处理")
            if names[0] == "纸张" or names[0] == "硬纸板":
                self.label_info.setText(
                    " 根据《城市生活垃圾分类及其评价标准》行业标准以及参考德国垃圾分类法，可回收物是指适宜回收循环使用和资源利用的废物。主要包括：纸类，塑料，金属，玻璃，织物等。主要的处理方式有：1.垃圾再生法；2.垃圾焚烧法；3.垃圾堆肥法；4.垃圾生物降解法。")
            if names[0] == "玻璃":
                self.label_info.setText(
                    "玻璃垃圾的处理需要大量能源和资源。玻璃在自然环境中分解需要数百年的时间。玻璃碎片可能会对人体和动物造成伤害")
            if names[0] == "金属":
                self.label_info.setText(
                    "金属垃圾的处理和回收需要大量能源和资源。金属的开采和加工会对环境造成严重破坏，包括土壤和水体的污染。部分金属元素对人体健康有害，如铅和汞")
            if names[0] == "塑料":
                self.label_info.setText(
                    "塑料垃圾对环境造成严重污染，尤其是海洋生态系统。塑料的生产和处理过程会释放有害化学物质，对人类健康和环境造成危害。塑料垃圾的分解需要数百年甚至上千年的时间，长期存在于土壤和水体中")
            self.result.setText(names[0])
            self.result_f.setText("识别成功")
        except Exception as e:
            print("预测图片出现异常:", str(e))
    # 窗口关闭事件
    def closeEvent(self, event):
        reply = QMessageBox.question(self,
                                     '退出',
                                     "是否要退出程序？",
                                     QMessageBox.Yes | QMessageBox.No,
                                     QMessageBox.No)
        if reply == QMessageBox.Yes:
            self.close()
            event.accept()
        else:
            event.ignore()
if __name__ == "__main__":
    app = QApplication(sys.argv)
    x = TrashClassificationWindow()
    x.show()
    sys.exit(app.exec_())
