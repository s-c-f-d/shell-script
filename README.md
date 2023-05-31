<!-- TOC -->

- [1. shell-script](#1-shell-script)
- [2. Git Scripts（git 相关脚本）](#2-git-scriptsgit-相关脚本)
    - [2.1. Auto Pull](#21-auto-pull)
        - [2.1.1. Run actions（会进行的操作）](#211-run-actions会进行的操作)
        - [2.1.2. Install CLI (安装命令)](#212-install-cli-安装命令)

<!-- /TOC -->

# 1. shell-script
Some Commonly Used Shell Scripts.(一些常用的 Shell 脚本)

# 2. Git Scripts（git 相关脚本）
## 2.1. Auto Pull
### 2.1.1. Run actions（会进行的操作）
* 1. Choose whether to ignore dependent script files in the .gitignore file according to user input.（<font color=green>根据用户输入选择是否在 .gitignore 文件中忽略依赖脚本文件。</font>）
* 2. Check whether the warehouse name entered by the user is valid.（<font color=green>检查用户输入的仓库名是否有效。</font>）
* 3. If the warehouse name is valid, then download the dependent script from the specified URL, and ignore this script in the .gitignore file according to the user's choice.（<font color=green>如果仓库名有效，那么就从指定的 URL 下载依赖脚本，并根据用户选择是否在 .gitignore 文件中忽略这个脚本。</font>）
* 4. Create a systemd service and a systemd timer to periodically execute downloaded dependent scripts.（<font color=green>创建一个 systemd service 和一个 systemd timer，用来定期执行下载的依赖脚本。</font>）
* 5. Start and enable the systemd service and systemd timer.（<font color=green>启动并启用这个 systemd service 和 systemd timer。</font>）

### 2.1.2. Install CLI (安装命令)
* One Key Install To Repo
    ```
    wget --no-check-certificate https://raw.githubusercontent.com/s-c-f-d/shell_script/master/install_auto_git_pull.sh && chmod a+x ./install_auto_git_pull.sh && ./install_auto_git_pull.sh
    ```