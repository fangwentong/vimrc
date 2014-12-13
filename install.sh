#!/bin/sh

BASE_DIR=`pwd`
TODAY=`date +%Y%m%d%H%M%S`

#配置Vim
echo "\033[34m* 备份vim配置...\033[0m"
for i in $HOME/.vim $HOME/.vimrc $HOME/.vimrc.bundles
do [ -L $i ] && unlink $i
done
for i in $HOME/.vim $HOME/.vimrc $HOME/.vimrc.bundles
do [ -e $i ] && mv $i $i.$TODAY
done

echo "\033[34m* 重新配置Vim...\033[0m"
ln -s $BASE_DIR/vimrc $HOME/.vimrc
ln -s $BASE_DIR/vimrc.bundles $HOME/.vimrc.bundles
ln -s $BASE_DIR/ $HOME/.vim

echo "\033[034m* 安装插件...\033[0m"
if [ ! -e $BASE_DIR/bundle/vundle ]
then
    echo "\033[034m* 安装Vundle...\033[0m"
    git clone https://github.com/gmarik/vundle.git $BASE_DIR/bundle/vundle
else
    echo "\033[034m* 升级Vundle...\033[0m"
    cd "$BASE_DIR/bundle/vundle" && git pull origin master
fi

echo "\033[034m* 使用Vundle安装/升级插件...\033[0m"
system_shell=$SHELL
export SHELL="/bin/sh"
echo "正在从GitHub上下载插件..." >> $BASE_DIR/notice
echo "请保持网络畅通，耐心等待 :-)" >> $BASE_DIR/notice
vim -u $HOME/.vimrc.bundles $BASE_DIR/notice +BundleInstall! +BundleClean +qall
rm $BASE_DIR/notice

echo "\033[034m* 编译YouCompleteMe...\033[0m"
echo "\033[034m* 请保持网络畅通，这可能会花费较长时间\033[0m"
echo "\033[034m* 编译会占用很多系统资源 :-)\033[0m"
echo "\033[034m* 若安装失败，请先检查依赖关系，再手动安装\033[0m"
cd $BASE_DIR/bundle/YouCompleteMe/

if [ `which clang` ]    #检查系统搜素路径中是否安装了clang
then
    bash -x install.sh --clang-completer --system-libclang
else
    bash -x install.sh --clang-completer
fi

export SHELL=$system_shell
#Vim配置完成
echo "\033[034m* Vim Configure completed!\033[0m"
