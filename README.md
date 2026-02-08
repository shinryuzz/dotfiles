# dotfiles

macOS 向けの個人用 dotfiles。XDG Base Directory 仕様に準拠。

## 構成

```
dotfiles/
├── alacritty/       # ターミナルエミュレータ設定
│   ├── alacritty.toml
│   └── themes/
├── zsh/             # シェル設定
│   ├── .zshenv      # 環境変数 (XDG, PATH)
│   ├── .zshrc       # シェル設定
│   └── .p10k.zsh    # Powerlevel10k テーマ
├── tmux/            # ターミナルマルチプレクサ設定
│   ├── tmux.conf
│   ├── keyconfig.conf
│   └── plugins.conf
├── nvim/            # Neovim 設定 (LazyVim)
├── hammerspoon/     # macOS 自動化
├── scripts/         # ユーティリティスクリプト
│   └── install-deps.sh
├── setup.sh         # シンボリックリンク作成
└── Makefile
```

## 必要環境

- macOS
- Git
- curl

## インストール

### 1. リポジトリのクローン

```sh
git clone https://github.com/shinryuzz/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. 依存ツールのインストール

```sh
make install-deps
```

以下がインストールされます:

| カテゴリ    | ツール                                                                |
| ----------- | --------------------------------------------------------------------- |
| Shell       | zsh, zsh-autosuggestions, zsh-syntax-highlighting, zsh-abbr, autojump |
| Terminal    | tmux, alacritty                                                       |
| Tools       | fzf, ghq, mise, neovim                                                |
| Development | git, gh, shellcheck                                                   |
| Framework   | Oh-My-Zsh, Powerlevel10k, TPM                                         |

### 3. シンボリックリンクの作成

```sh
make init
```

既存のシンボリックリンクを上書きする場合:

```sh
make init-force
```

### 4. tmux プラグインのインストール

tmux を起動後、`prefix + I` でプラグインをインストール。

## 主要な設定

### Zsh

- **プロンプト**: Powerlevel10k (rainbow style)
- **プラグイン管理**: Oh-My-Zsh
- **プラグイン**: zsh-autosuggestions, zsh-syntax-highlighting, autojump
- **エイリアス展開**: zsh-abbr

| キーバインド | 機能                       |
| ------------ | -------------------------- |
| `Ctrl+R`     | fzf でコマンド履歴検索     |
| `Ctrl+]`     | fzf + ghq でリポジトリ移動 |

### Tmux

- **Prefix**: `Ctrl+T`
- **テーマ**: Catppuccin Mocha
- **セッション永続化**: tmux-resurrect + tmux-continuum

| キーバインド      | 機能               |
| ----------------- | ------------------ |
| `prefix + r`      | 設定リロード       |
| `prefix + Ctrl+D` | デタッチ           |
| `prefix + e`      | 他のペインを閉じる |

### Alacritty

- 起動時に自動で tmux セッション (`home`) にアタッチ
- Vi モード: `Ctrl+Shift+T` でトグル
- テーマ: OneDark

## Makefile コマンド

```sh
make help          # ヘルプ表示
make install-deps  # 依存ツールをインストール
make init          # シンボリックリンクを作成
make init-force    # シンボリックリンクを強制上書き
make lint          # シェルスクリプトの lint
make update        # プラグイン等を更新
```

## XDG Base Directory

このdotfilesは XDG Base Directory 仕様に準拠しています:

| 変数              | パス             | 用途           |
| ----------------- | ---------------- | -------------- |
| `XDG_CONFIG_HOME` | `~/.config`      | 設定ファイル   |
| `XDG_DATA_HOME`   | `~/.local/share` | データファイル |
| `XDG_STATE_HOME`  | `~/.local/state` | 状態ファイル   |
| `XDG_CACHE_HOME`  | `~/.cache`       | キャッシュ     |
