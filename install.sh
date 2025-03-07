#!/bin/bash

red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
bblue='\033[0;34m'
plain='\033[0m'
red(){ echo -e "\033[31m\033[01m$1\033[0m";}
green(){ echo -e "\033[32m\033[01m$1\033[0m";}
yellow(){ echo -e "\033[33m\033[01m$1\033[0m";}
blue(){ echo -e "\033[36m\033[01m$1\033[0m";}
white(){ echo -e "\033[37m\033[01m$1\033[0m";}
readp(){ read -p "$(yellow "$1")" $2;}
clear
green "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"           
echo -e "${bblue} ░██   ░██     ░██   ░██     ░██${plain}   ░██    ░██     ░██      ░██ ██ ${red}██${plain} "
echo -e "${bblue} ░██  ░██      ░██  ░██${plain}      ░██  ░██      ░██   ░██      ░██    ${red}░░██${plain} "            
echo -e "${bblue} ░██ ██        ░██${plain} ██        ░██ ██         ░██ ░██      ░${red}██        ${plain} "
echo -e "${bblue} ░██ ██       ${plain} ░██ ██        ░██ ██           ░██        ${red}░██    ░██ ██${plain} "
echo -e "${bblue} ░██ ░${plain}██       ░██ ░██       ░██ ░██          ░${red}██         ░██    ░░██${plain}"
echo -e "${bblue} ░${plain}██  ░░██     ░██  ░░██     ░██  ░░${red}██        ░██          ░██ ██ ██${plain} "
green "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" 
white "甬哥Github项目  ：github.com/ygkkkyb"
white "甬哥blogger博客 ：ygkkk.blogspot.com"
white "甬哥YouTube频道 ：www.youtube.com/c/甬哥侃侃侃kkkyg"
yellow "感谢x-ui代码贡献者们在上游的更新维护"
yellow "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" 
sleep 2
cur_dir=$(pwd)

# check root
[[ $EUID -ne 0 ]] && echo -e "${red}错误：${plain} 必须使用root用户运行此脚本！\n" && exit 1

# check os
if [[ -f /etc/redhat-release ]]; then
    release="centos"
elif cat /etc/issue | grep -Eqi "debian"; then
    release="debian"
elif cat /etc/issue | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
elif cat /proc/version | grep -Eqi "debian"; then
    release="debian"
elif cat /proc/version | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
elif cat /etc/system-release-cpe | grep -Eqi "amazon_linux"; then
    release="amazon_linux"
else
    echo -e "${red}未检测到系统版本，请联系脚本作者！${plain}\n" && exit 1
fi

arch=$(arch)

if [[ $arch == "x86_64" || $arch == "x64" || $arch == "amd64" ]]; then
  arch="amd64"
elif [[ $arch == "aarch64" || $arch == "arm64" ]]; then
  arch="arm64"
elif [[ $arch == "s390x" ]]; then
  arch="s390x"
else
  arch="amd64"
  echo -e "${red}检测架构失败，使用默认架构: ${arch}${plain}"
fi
sys(){
[ -f /etc/os-release ] && grep -i pretty_name /etc/os-release | cut -d \" -f2 && return
[ -f /etc/lsb-release ] && grep -i description /etc/lsb-release | cut -d \" -f2 && return
[ -f /etc/redhat-release ] && awk '{print $0}' /etc/redhat-release && return;}
op=`sys`
version=`uname -r | awk -F "-" '{print $1}'`
vi=`systemd-detect-virt`
white "VPS操作系统: $(blue "$op") \c" && white " 内核版本: $(blue "$version") \c" && white " CPU架构 : $(blue "$arch") \c" && white " 虚拟化类型: $(blue "$vi")"
sleep 2

if [ $(getconf WORD_BIT) != '32' ] && [ $(getconf LONG_BIT) != '64' ] ; then
    echo "本软件不支持 32 位系统(x86)，请使用 64 位系统(x86_64)，如果检测有误，请联系作者"
    exit -1
fi

os_version=""

# os version
if [[ -f /etc/os-release ]]; then
    os_version=$(awk -F'[= ."]' '/VERSION_ID/{print $3}' /etc/os-release)
fi
if [[ -z "$os_version" && -f /etc/lsb-release ]]; then
    os_version=$(awk -F'[= ."]+' '/DISTRIB_RELEASE/{print $2}' /etc/lsb-release)
fi

if [[ x"${release}" == x"centos" ]]; then
    if [[ ${os_version} -le 6 ]]; then
        echo -e "${red}请使用 CentOS 7 或更高版本的系统！${plain}\n" && exit 1
    fi
elif [[ x"${release}" == x"ubuntu" ]]; then
    if [[ ${os_version} -lt 16 ]]; then
        echo -e "${red}请使用 Ubuntu 16 或更高版本的系统！${plain}\n" && exit 1
    fi
elif [[ x"${release}" == x"debian" ]]; then
    if [[ ${os_version} -lt 8 ]]; then
        echo -e "${red}请使用 Debian 8 或更高版本的系统！${plain}\n" && exit 1
    fi
elif [[ x"${release}" == x"amazon_linux" ]]; then
    if [[ ${os_version} -lt 2 ]]; then
        echo -e "${red}请使用 Amazon Linux 2 或更高版本的系统！${plain}\n" && exit 1
    fi
fi
ports=$(/usr/local/x-ui/x-ui 2>&1 | grep tcp | awk '{print $5}' | sed "s/://g")
if [[ -n $ports ]]; then
green "经检测，x-ui已安装"
echo
acp=$(/usr/local/x-ui/x-ui setting -show 2>/dev/null)
green "$acp"
echo
readp "是否直接覆盖重装x-ui（Y/y键）？(不重装，非Y/y键，退出脚本):" ins
if [[ $ins = [Yy] ]]; then
systemctl stop x-ui
systemctl disable x-ui
rm /etc/systemd/system/x-ui.service -f
systemctl daemon-reload
systemctl reset-failed
rm /etc/x-ui/ -rf
rm /usr/local/x-ui/ -rf
rm -rf goxui.sh acme.sh
sed -i '/goxui.sh/d' /etc/crontab
sed -i '/x-ui restart/d' /etc/crontab
else
exit 1
fi
fi
install_base() {
if [[ x"${release}" == x"centos" ]]; then
if [[ ${os_version} =~ 8 ]]; then
cd /etc/yum.repos.d/ && mkdir backup && mv *repo backup/ 
curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-8.repo
sed -i -e "s|mirrors.cloud.aliyuncs.com|mirrors.aliyun.com|g " /etc/yum.repos.d/CentOS-*
sed -i -e "s|releasever|releasever-stream|g" /etc/yum.repos.d/CentOS-*
yum clean all && yum makecache
fi
yum install epel-release -y && yum install wget curl tar -y
else
apt update && apt install wget curl tar -y
fi
vi=`systemd-detect-virt`
if [[ $vi = openvz ]]; then
TUN=$(cat /dev/net/tun 2>&1)
if [[ ${TUN} != "cat: /dev/net/tun: File descriptor in bad state" ]]; then 
red "检测到未开启TUN，现尝试添加TUN支持" && sleep 2
cd /dev
mkdir net
mknod net/tun c 10 200
chmod 0666 net/tun
TUN=$(cat /dev/net/tun 2>&1)
if [[ ${TUN} != "cat: /dev/net/tun: File descriptor in bad state" ]]; then 
green "添加TUN支持失败，建议与VPS厂商沟通或后台设置开启" && exit 0
else
green "恭喜，添加TUN支持成功，现执行重启VPS自动开启TUN守护功能" && sleep 2
cat>/root/tun.sh<<-\EOF
#!/bin/bash
cd /dev
mkdir net
mknod net/tun c 10 200
chmod 0666 net/tun
EOF
chmod +x /root/tun.sh
grep -qE "^ *@reboot root bash /root/tun.sh >/dev/null 2>&1" /etc/crontab || echo "@reboot root bash /root/tun.sh >/dev/null 2>&1" >> /etc/crontab
green "重启VPS自动开启TUN守护功能已启动"
fi
fi
fi
echo -e "${green}关闭防火墙，开放所有端口规则……${plain}"
sleep 1
systemctl stop firewalld.service >/dev/null 2>&1
systemctl disable firewalld.service >/dev/null 2>&1
setenforce 0 >/dev/null 2>&1
ufw disable >/dev/null 2>&1
iptables -P INPUT ACCEPT >/dev/null 2>&1
iptables -P FORWARD ACCEPT >/dev/null 2>&1
iptables -P OUTPUT ACCEPT >/dev/null 2>&1
iptables -t nat -F >/dev/null 2>&1
iptables -t mangle -F >/dev/null 2>&1
iptables -F >/dev/null 2>&1
iptables -X >/dev/null 2>&1
netfilter-persistent save >/dev/null 2>&1
if [[ -z $(grep 'DiG 9' /etc/hosts) ]]; then
v4=$(curl -s4m3 https://ip.gs -k)
if [ -z $v4 ]; then
echo -e "${green}检测到VPS为纯IPV6 Only,添加dns64${plain}\n"
echo -e nameserver 2a01:4f8:c2c:123f::1 > /etc/resolv.conf
fi
fi
}

install_x-ui() {
    systemctl stop x-ui
    cd /usr/local/

    if  [ $# == 0 ] ;then
        wget -N --no-check-certificate -O /usr/local/x-ui-linux-${arch}.tar.gz https://raw.githubusercontents.com/ygkkkyb/x-ui-yg/main/x-ui-linux-${arch}.tar.gz
        if [[ $? -ne 0 ]]; then
            echo -e "${red}下载 x-ui 失败，请确保你的服务器能够下载 Github 的文件${plain}"
            rm -rf install.sh
            exit 1
        fi
    else
        last_version=$1
        url="https://raw.githubusercontents.com/ygkkkyb/x-ui-yg/main/x-ui-linux-${arch}.tar.gz"
        echo -e "开始安装 x-ui v$1"
        wget -N --no-check-certificate -O /usr/local/x-ui-linux-${arch}.tar.gz ${url}
        if [[ $? -ne 0 ]]; then
            echo -e "${red}下载 x-ui v$1 失败，请确保此版本存在${plain}"
            rm -rf install.sh
            exit 1
        fi
    fi

    if [[ -e /usr/local/x-ui/ ]]; then
        rm /usr/local/x-ui/ -rf
    fi

    tar zxvf x-ui-linux-${arch}.tar.gz
    rm x-ui-linux-${arch}.tar.gz -f
    cd x-ui
    chmod +x x-ui bin/xray-linux-${arch}
    cp -f x-ui.service /etc/systemd/system/
    wget --no-check-certificate -O /usr/bin/x-ui https://raw.githubusercontents.com/ygkkkyb/x-ui-yg/main/x-ui.sh
    chmod +x /usr/bin/x-ui
    chmod +x /usr/local/x-ui/x-ui.sh
    systemctl daemon-reload
    systemctl enable x-ui
    systemctl start x-ui
green "安装每分种自检x-ui的守护进程" 
sleep 2
cat>/root/goxui.sh<<-\EOF
#!/bin/bash
xui=`ps -aux |grep "x-ui" |grep -v "grep" |wc -l`
xray=`ps -aux |grep "xray" |grep -v "grep" |wc -l`
sleep 1
if [ $xui = 0 ];then
x-ui restart
fi
if [ $xray = 0 ];then
x-ui restart
fi
EOF
chmod +x /root/goxui.sh
sed -i '/goxui.sh/d' /etc/crontab
echo "*/1 * * * * root bash /root/goxui.sh >/dev/null 2>&1" >> /etc/crontab
green "x-ui守护进程设置完毕" && sleep 1
green "设置x-ui每月1日自动重启一次，防止x-ui对自动续期后的证书不识别问题"
sed -i '/x-ui restart/d' /etc/crontab
echo "0 1 1 * * x-ui restart >/dev/null 2>&1" >> /etc/crontab
sleep 1
echo -e ""
blue "以下设置内容建议自定义，以防止账号密码及端口泄露"
echo -e ""
readp "设置x-ui登录用户名（不建议回车跳过使用默认用户名admin）：" username
readp "设置x-ui登录密码（不建议回车跳过使用默认密码admin）：" password
if [[ -z ${username} ]]; then
username=admin
fi
if [[ -z ${password} ]]; then
password=admin
fi
/usr/local/x-ui/x-ui setting -username ${username} -password ${password} >/dev/null 2>&1
sleep 1
echo -e ""
readp "设置x-ui登录端口[1-65535]（不建议回车跳过使用默认端口54321）：" port
if [[ -z $port ]]; then
/usr/local/x-ui/x-ui setting -port 54321 >/dev/null 2>&1
else
until [[ -z $(ss -ntlp | awk '{print $4}' | grep -w "$port") ]]
do
[[ -n $(ss -ntlp | awk '{print $4}' | grep -w "$port") ]] && yellow "\n端口被占用，请重新输入端口" && readp "自定义x-ui端口:" port
done
/usr/local/x-ui/x-ui setting -port ${port} >/dev/null 2>&1
fi
x-ui restart
xuilogin(){
v4=$(curl -s4m3 https://ip.gs -k)
v6=$(curl -s6m3 https://ip.gs -k)
if [[ -z $v4 ]]; then
int="${green}请在浏览器地址栏复制${plain}  ${bblue}[$v6]:$ports${plain}  ${green}进入x-ui登录界面\n当前x-ui登录用户名：${plain}${bblue}${username}${plain}${green} \n当前x-ui登录密码：${plain}${bblue}${password}${plain}"
elif [[ -n $v4 && -n $v6 ]]; then
int="${green}请在浏览器地址栏复制${plain}  ${bblue}$v4:$ports${plain}  ${yellow}或者${plain}  ${bblue}[$v6]:$ports${plain}  ${green}进入x-ui登录界面\n当前x-ui登录用户名：${plain}${bblue}${username}${plain}${green} \n当前x-ui登录密码：${plain}${bblue}${password}${plain}"
else
int="${green}请在浏览器地址栏复制${plain}  ${bblue}$v4:$ports${plain}  ${green}进入x-ui登录界面\n当前x-ui登录用户名：${plain}${bblue}${username}${plain}${green} \n当前x-ui登录密码：${plain}${bblue}${password}${plain}"
fi
}
ports=$(/usr/local/x-ui/x-ui 2>&1 | grep tcp | awk '{print $5}' | sed "s/://g")
if [[ -n $ports ]]; then
echo -e ""
yellow "x-ui安装成功，请稍等3秒，检测IP环境，输出x-ui登录信息……"
wgcfv6=$(curl -s6m6 https://www.cloudflare.com/cdn-cgi/trace -k | grep warp | cut -d= -f2)
wgcfv4=$(curl -s4m6 https://www.cloudflare.com/cdn-cgi/trace -k | grep warp | cut -d= -f2)
if [[ ! $wgcfv4 =~ on|plus && ! $wgcfv6 =~ on|plus ]]; then
xuilogin
else
systemctl stop wg-quick@wgcf >/dev/null 2>&1
xuilogin
systemctl start wg-quick@wgcf >/dev/null 2>&1
fi
else
red "x-ui安装失败，请查看日志，运行 x-ui log，反馈到https://github.com/ygkkkyb/x-ui-yg/issues"
fi
    sleep 1
    echo -e ""
    echo -e "$int"
    echo -e ""
    echo -e "x-ui 管理脚本使用方法: "
    echo -e "----------------------------------------------"
    echo -e "x-ui              - 显示管理菜单 (一键证书申请，简单版BBR+FQ加速，账号、密码、端口显示)"
    echo -e "x-ui start        - 启动 x-ui 面板"
    echo -e "x-ui stop         - 停止 x-ui 面板"
    echo -e "x-ui restart      - 重启 x-ui 面板"
    echo -e "x-ui status       - 查看 x-ui 状态"
    echo -e "x-ui enable       - 设置 x-ui 开机自启"
    echo -e "x-ui disable      - 取消 x-ui 开机自启"
    echo -e "x-ui log          - 查看 x-ui 日志"
    echo -e "x-ui v2-ui        - 迁移本机器的 v2-ui 账号数据至 x-ui"
    echo -e "x-ui update       - 更新 x-ui 面板"
    echo -e "x-ui install      - 安装 x-ui 面板"
    echo -e "x-ui uninstall    - 卸载 x-ui 面板"
    echo -e "----------------------------------------------"
    rm -rf install.sh
}

echo -e "${green}开始安装x-ui必要依赖${plain}"
install_base
echo -e "${green}开始安装x-ui核心组件${plain}"
install_x-ui $1
