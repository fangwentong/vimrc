#!/bin/sh

BASE_DIR=`pwd`
TODAY=`date +%Y%m%d%H%M%S`

install_mac_os() {
    brew install vim ctags

    brew install python
    pip install pyflakes pylint pep8

    brew install node
    npm install jshint -g
    npm install jslint -g
}

install_debain() {
    sudo apt-get install -y clang cmake build-essential 2>> err.log

    # 解决Ubuntu 14.04编译YCM时找不到libclang.so的问题
    for CLANG_VERSION in 3.9 3.8 3.7 3.6 3.5 3.4 3.3 3.2 3.1
    do
        if [ ! -e /usr/lib/llvm-$CLANG_VERSION/lib/libclang.so ] && [ -e /usr/lib/llvm-$CLANG_VERSION/lib/libclang.so.1 ]
        then
            sudo ln -sf /usr/lib/llvm-$CLANG_VERSION/lib/libclang.so.1 /usr/lib/llvm-$CLANG_VERSION/lib/libclang.so
            echo "Here"
        elif [ -L /usr/lib/llvm-$CLANG_VERSION/lib/libclang.so ]
        then
            sudo unlink /usr/lib/llvm-$CLANG_VERSION/lib/libclang.so
            sudo ln -sf /usr/lib/llvm-$CLANG_VERSION/lib/libclang.so.1 /usr/lib/llvm-$CLANG_VERSION/lib/libclang.so
        fi
    done

    sudo apt-get install -y vim ctags 2>> err.log
    sudo apt-get install -y python-dev python-setuptools 2>> err.log
    sudo easy_install pip
    sudo pip install pyflakes pylint pep8

    sudo apt-get install -y nodejs-legacy npm 2>> err.log
    sudo npm install jslint -g
    sudo npm install jshint -g
}

install_fedora() {
    sudo yum install vim -y
    sudo yum install python-devel.x86_64
    sudo yum groupinstall 'Development Tools'
}

install_vim() {
    echo "\033[034m* Installing vim...\033[0m"
    SYSTEM=`uname -s`
    if [ $SYSTEM = "Darwin" ]
    then
        install_mac_os
    elif [ `which apt-get` ]
    then
        install_debain
    elif [ `which yum` ]
    then
        install_fedora
    fi
}

# Configure Vim
link_vimrc() {
    echo "\033[34m* Backing up vim configure...\033[0m"
    for i in $HOME/.vim $HOME/.vimrc $HOME/.vimrc.bundles; do [ -L $i ] && unlink $i; done
    for i in $HOME/.vim $HOME/.vimrc $HOME/.vimrc.bundles; do [ -e $i ] && mv $i $i.$TODAY; done

    echo "\033[34m* Setting up symlinks...\033[0m"
    ln -s $BASE_DIR/vimrc $HOME/.vimrc
    ln -s $BASE_DIR/vimrc.bundles $HOME/.vimrc.bundles
    ln -s $BASE_DIR $HOME/.vim
}

# Install Plugins
install_plugins() {
    if [ ! -e $BASE_DIR/bundle/vundle ]; then
        echo "\033[034m* Installing Vundle...\033[0m"
        git clone https://github.com/gmarik/vundle.git $BASE_DIR/bundle/vundle
    else
        echo "\033[034m* Upgrading Vundle...\033[0m"
        cd "$BASE_DIR/bundle/vundle" && git pull origin master
    fi

    echo "\033[034m* Upgrading/Installing plugins using Vundle...\033[0m"
    echo "Downloading plugins from GitHub..." >>$BASE_DIR/notice
    vim -u $HOME/.vimrc.bundles $BASE_DIR/notice +BundleInstall! +BundleClean +qall
    rm $BASE_DIR/notice
}

javascript_tern_config() {
    cd ~/.vim/bundle/tern_for_vim && sudo npm install
    ln -sf $BASE_DIR/conf/tern-project $HOME/.tern-project
}

plugins_configure() {
    javascript_tern_config
}

# Compile YouCompleteMe
compile_ycm() {
    echo "\033[034m* Compiling YouCompleteMe...\033[0m"
    cd $BASE_DIR/bundle/YouCompleteMe/
    if [ `which clang` ]    #Check system clang
    then
        bash -x install.sh --clang-completer --system-libclang # use system clang
    else
        bash -x install.sh --clang-completer
    fi
}

################# Start ########################
install_vim
link_vimrc
install_plugins
plugins_configure
compile_ycm
# Vim configure complete
echo "\033[034m* Vim Configure completed!\033[0m"
################ End ###########################
