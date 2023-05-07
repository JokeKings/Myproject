import pygame#引用第三方模块
import random#随机数据
from pygame.locals import*
# 1:实现飞机的显示，并且可以控制飞机的移动
#抽象出来一个飞机的基类
class basepalne(object):
    def __init__(self,screen,imagePath):
        self.screen=screen
        self.image=pygame.image.load(imagePath)
        self.bulletlist=[]#存储所有的子弹
        pass
    def display(self):
        self.screen.blit(self.image, (self.x, self.y))
        # 完善子弹的展示逻辑
        needdelitemlist = []
        for item in self.bulletlist:
            if item.judge():
                needdelitemlist.append(item)
                pass
            pass
        # 重新遍历一下
        for i in needdelitemlist:
            self.bulletlist.remove(i)
            pass
        for itemB in self.bulletlist:
            itemB.display()  # 显示子弹的位置
            itemB.move()  # 让这个子弹进行移动，下次再显示的时候就会看到子弹在修改后的的位置
        pass

class commbullet(object):
    '''
    公共的子弹类
    '''
    def  __init__(self,x,y,screen,bulletType):
        self.type=bulletType
        self.screen=screen
        if self.type=='hero':
            self.x=x+13
            self.y=y-20
            self.imagePath='./feiji/bullet.png'
        elif self.type == 'enemy':
            self.x = x
            self.y =y+10
            self.imagePath = './feiji/bullet1.png'
            pass
        self.image=pygame.image.load(self.imagePath)
        pass
    def move(self):
        '''
        子弹的移动
        :return:
        '''
        if self.type=='hero':
            self.y-=2
        elif self.type=='enemy':
            self.y+=2
        pass
    def display(self):
        self.screen.blit(self.image,(self.x,self.y))
        pass
    def judge(self):
        '''
        判断子弹是否越界
        :return:
        '''
        if self.y>500 or self.y<0:
            return True
        else:
            return False
        pass
    pass

class heroplane(basepalne):
    def __init__(self, screen):
        super().__init__(screen,'./feiji/hero.png')#调用父类的构造方法
        #应该具备的属性
        self.x=400
        self.y=800
        pass
    def moveleft(self):
        if self.x>0:
            self.x-=30
        pass
    def moveright(self):
        if self.x<1400:
            self.x+=30;
        pass
    def diaplay(self):
        self.screen.blit(self.image,(self.x,self.y))
        # 完善子弹的展示逻辑
        needdelitemlist=[]
        for item in self.bulletlist:
            if item.judge():
                needdelitemlist.append(item)
                pass
            pass
        # 重新遍历一下
        for i in needdelitemlist:
            self.bulletlist.remove(i)
            pass
        for itemB in self.bulletlist:
            itemB.display()#显示子弹的位置
            itemB.move()#让这个子弹进行移动，下次再显示的时候就会看到子弹在修改后的的位置
        pass
    def sheBullet(self):
        newBullet=commbullet(self.x,self.y,self.screen,"hero")
        self.bulletlist.append(newBullet)
        pass

# 创建敌人的飞机
class eneplane(basepalne):
    def __init__(self, screen):
        #默认设置一个方向
        super().__init__(screen,'./feiji/enemy0.png')
        self.direction='right'#默认自动右方向移动
        # 应该具备的属性
        self.x = 0
        self.y = 0
    def shBullet(self):
        #敌机发射
        num=random.randint(1,50)
        if num==3:
            newBullet=commbullet(self.x,self.y,self.screen,"enemy")
            self.bulletlist.append(newBullet)
        pass
    def move(self):
        #敌机移动随机
        if self.direction=='right':
            self.x+=10
        elif self.direction=='left':
            self.x-=10
        if self.x>1440-20:
            self.direction='left'
        elif self.x<0:
            self.direction='right'
        pass


def key_control(heroobj):
    #定义普通函数，用来实现键盘的检测
    # 获取键盘事件
    for event in pygame.event.get():
        # 判断是否点击了退出按钮
        if event.type == QUIT:
            print('exit')
            exit()
        # 判断是否按下了键
        elif event.type == KEYDOWN:
            # 检测是否是a或者left
            if event.type == K_a or event.key == K_LEFT:
                print('left')
                heroobj.moveleft()#调用左移函数
            # 检测是否是d或者right
            if event.type == K_d or event.key == K_RIGHT:
                print('right')
                heroobj.moveright()#调用右移函数
            #           #检测按键是否有空格键
            elif event.key == K_SPACE:
                print('space')
                heroobj.sheBullet()

def main():
    #首先创建一个窗口，用来显示内容
    screen=pygame.display.set_mode((1440,900),depth=32)
    # 设定一个背景图片
    backguand=pygame.image.load('./feiji/1111056.png')
    #设置一个标题
    pygame.display.set_caption('阶段总结，飞机小游戏')

    # 添加背景音乐
    pygame.mixer.init()
    pygame.mixer.music.load('./feiji/2.flac')
    pygame.mixer.music.set_volume(2)
    pygame.mixer.music.play(-1)#循环次数，-1表示无限循环


    #创建一个飞机对象
    hero = heroplane(screen)
    # 创建一个敌机对象
    enemyplane=eneplane(screen)
    #设定要显示的内容
    while True:
        screen.blit(backguand,(0,0))
        # 显示玩家飞机的图片
        hero.diaplay()
        enemyplane.display()#显示敌机
        enemyplane.move()#敌机移动
        enemyplane.shBullet()#随机发射子弹
        #获取键盘事件
        key_control(hero)
        #更新显示的内容
        pygame.display.update()
    pass
if __name__=='__main__':
    main()
