#!/bin/bash
set -e
# SLIENCE Mode(静默模式) ---[default(默认值)：0,  Add ignore files to prevent conflicts caused by modifying synchronization script permissions when git pull(添加忽略文件,防止git pull 时因为修改同步脚本权限导致的冲突)] 
IS_SLIENCE=0

SCRIPT_NAME=install_auto_git_pull

DEPENDENCY_SCRIPT_NAME=git_pull
DEPENDENCY_SCRIPT_URL=https://raw.githubusercontent.com/s-c-f-d/shell-script/master/$DEPENDENCY_SCRIPT_NAME.sh

Install(){
    REPO_NAME=$1

    wget --no-check-certificate $DEPENDENCY_SCRIPT_URL && chmod a+x ./$DEPENDENCY_SCRIPT_NAME.sh
    if [ $IS_SLIENCE -eq 0 ]; then
        echo "$DEPENDENCY_SCRIPT_NAME.sh" >> ./.gitignore
    else
        sed -i -e "/$DEPENDENCY_SCRIPT_NAME.sh/d" ./.gitignore
    fi

    # Create Script.service
    echo "[Unit]
    Description=Git pull $REPO_NAME service
    After=network-online.target
    Wants=network-online.target

    [Service]
    Type=simple
    User=root
    Restart=on-failure
    RestartSec=5s
    ExecStart=$PWD/$DEPENDENCY_SCRIPT_NAME.sh
    WorkingDirectory=$PWD

    [Install]
    WantedBy=multi-user.target" > /etc/systemd/system/${DEPENDENCY_SCRIPT_NAME}_${REPO_NAME}.service

    # Create Script.timer
    echo "[Unit]
    Description=Runs ${DEPENDENCY_SCRIPT_NAME}_${REPO_NAME} Service every 5 minutes

    [Timer]
    OnBootSec=5min
    OnUnitActiveSec=5min
    Unit=${DEPENDENCY_SCRIPT_NAME}_${REPO_NAME}.service

    [Install]
    WantedBy=timers.target" > /etc/systemd/system/${DEPENDENCY_SCRIPT_NAME}_${REPO_NAME}.timer

    # Reload systemd
    sudo systemctl daemon-reload
    sudo systemctl start ${DEPENDENCY_SCRIPT_NAME}_${REPO_NAME}.service
    sudo systemctl enable ${DEPENDENCY_SCRIPT_NAME}_${REPO_NAME}.service
    sudo systemctl start ${DEPENDENCY_SCRIPT_NAME}_${REPO_NAME}.timer
    sudo systemctl enable ${DEPENDENCY_SCRIPT_NAME}_${REPO_NAME}.timer
}


is_valid_repo_name() {
    if [[ $1 =~ ^[a-z0-9_-]+$ ]]; then
        return 0
    else
        return 1
    fi
}

input_repo_name(){
    while true; do
        echo "==== Please Input Repo Name ===="
        read -p "Please Input(请输入): " input_string
        if is_valid_repo_name "$input_string"; then
            Install "$input_string"
            break
        else
            echo ""
            echo "---!!! Invalid Repo Name !!!---"
            echo "---!!! Invalid Repo Name !!!---"
            echo "---!!! Invalid Repo Name !!!---"
            echo ""
        fi
    done
}

echo "============================ ${produckName} ============================"
echo "  1、SLIENCE [Add ignore files to prevent conflicts caused by modifying synchronization script permissions when git pull]"
echo "  1、静默模式 [防止git pull时因为修改同步脚本权限导致的冲突]"
echo "  2、Normal [Do not make any additional settings, if there is a conflict in git pull, you need to integrate it into the Repo by yourself]"
echo "  2、常规模式 [不做任何额外设置，如果gitpull出现冲突，需要自行集成到Repo中]"
echo "======================================================================"
read -p "$(echo -e "Please Choose(请选择): [1-2]：")" choose
case $choose in
1)
    IS_SLIENCE=0
    input_repo_name && wait && rm -rf ${SCRIPT_NAME}.sh
    ;;
2)
    IS_SLIENCE=1
    input_repo_name && wait && rm -rf ${SCRIPT_NAME}.sh
    ;;
*)
    echo "Input Error Please ReTry (输入错误，请重新输入)！"
    ;;
esac





