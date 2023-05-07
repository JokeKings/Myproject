print("游戏开始")
print('-'*20,'欢迎光临唐僧大战白骨精','-'*20)
print("请选择身份  ")
print("\t1 唐僧\n\t2 白骨精")
print("-"*80)
#选择身份
play_choose=input("请选择[1-2]: ")
if play_choose=="1":
    print("你将以唐僧身份进行游戏")
elif play_choose=="2":
    print("想选白骨精，不可能的，老老实实当唐僧吧")
else :
    print("系统自动帮你分配唐僧")
print()
print("-"*803)
print("-"*80)
print()
# 进入游戏

# 创建变量，保存玩家的生命和攻击力
# 显示玩家的信息
play_life=100#生命值
play_attack=120
# 显示boss信息
boss_life=1000
boss_attack=15
# 显示玩家的信息(攻击力和生命值)
print(f"唐僧\n生命值\t{play_life}\n攻击力\t{play_attack}")
print()
print("-"*80)
print("-"*80)
print()
# 显示游戏选项需要反复的，所以必须将其写入循环中
while True:
    print("-"*80) 
    print("请选择你要进行的操作：")
    print("\t1 练级")
    print("\t2 打boss")
    print("\t3 逃跑")
    game_choose=input("请选择要进行的操作[1-3]: ")
# 进行游戏选择
    if game_choose=="1":
        play_life+=2
        play_attack+=10
        print(f"恭喜你升级了！你现在的生命值是{play_life},攻击力是{play_attack}")
    elif game_choose=="2":
        # 玩家攻击boss
        # 减去boss生命值
        # boss攻击玩家
        print("唐僧攻击白骨精")
        boss_life-=play_attack
        print(f"白骨精受到{play_attack}点伤害")
        # 判断boss是否死亡
        if boss_life<=0:
            print("唐僧击败了白骨精，游戏胜利")
        # 游戏结束
            break
        # boss攻击玩家
        play_life-=boss_attack
        print("白骨精攻击唐僧")
        print(f"唐僧受到{boss_attack}点伤害")
        print(f"白骨精的生命值{boss_life}\n唐僧的生命值{play_life}")
        if play_life<=0:
            print(f"你受到了{boss_attack}点伤害，死亡，游戏结束(game over)")
            break
    elif game_choose=="3":
        print("跑个der，游戏结束小菜鸡\n\tgame over")
        break
    else :
        print("输入有误，请重新输入")

