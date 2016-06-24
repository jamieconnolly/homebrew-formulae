class PyenvVirtualenvExt < Formula
  desc "Make pyenv transparently aware of a virtual environment"
  homepage "https://github.com/jamieconnolly/pyenv-virtualenv-ext"
  url "https://github.com/jamieconnolly/pyenv-virtualenv-ext/archive/0.5.1.tar.gz"
  sha256 "e2c3995eb035d95514bcc510fbfbf73a8f7440aa0649354c8a4a297209090c5e"

  head "https://github.com/jamieconnolly/pyenv-virtualenv-ext.git"

  bottle :unneeded

  depends_on "pyenv"
  depends_on "pyenv-virtualenv"

  def install
    ENV["PREFIX"] = prefix
    system "./install.sh"
  end

  test do
    assert_match "virtualenv-ext.bash", shell_output("pyenv hooks version-name")
    assert_match "virtualenv-ext.bash", shell_output("pyenv hooks version-origin")
  end
end
