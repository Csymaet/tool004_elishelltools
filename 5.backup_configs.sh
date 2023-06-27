#!/bin/bash
# by gpt

# 声明数组，存储文件路径
paths=(
  "/etc/pacman.conf"                      # pacman
  "/etc/sddm.conf.d/sddm.conf"            # sddm
  "${HOME}/.gitconfig"                    # git
  "${HOME}/.SpaceVim.d/init.toml"         # spacevim
  "${HOME}/.config/pgcli"                 # pgcli
  "${HOME}/.config/i3"                    # i3
  "${HOME}/.zshrc"                        # zsh
  "${HOME}/.config/jrnl/jrnl.yaml"        # jrnl
)

sudo_paths=(
  "/etc/sudoers"                          # pacman
)

# 使用 for 循环遍历数组，将文件复制到 指定 目录
for path in "${paths[@]}"
do
  cp -r $path ./cardbox/016-config_box    # 复制文件到 指定 目录
done

for path in "${sudo_paths[@]}"
do
  sudo cp $path ./cardbox/016-config_box    # 复制文件到 指定 目录
  sudo chmod 644 ./cardbox/016-config_box/$(basename $path)   # 修改复制后的文件权限为 644
  sudo chown eli:eli ./cardbox/016-config_box/$(basename $path) # 修改所属用户和组
done

echo "备份完成！"
