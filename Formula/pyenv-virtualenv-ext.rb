class PyenvVirtualenvExt < Formula
  desc "Make pyenv transparently aware of a virtual environment"
  homepage "https://github.com/jamieconnolly/pyenv-virtualenv-ext"
  url "https://github.com/jamieconnolly/pyenv-virtualenv-ext/archive/0.1.1.tar.gz"
  sha256 "0ba8a7ab3489115197a1e6839383caa499e716b56f1dd5a87d96c6039c3c0e0c"

  head "https://github.com/jamieconnolly/pyenv-virtualenv-ext.git"

  bottle :unneeded

  depends_on "pyenv"
  depends_on "pyenv-virtualenv"

  def install
    ENV["PREFIX"] = prefix
    system "./install.sh"
  end

  test do
    assert_match "virtualenv-ext.bash", shell_output("pyenv hooks exec")
    assert_match "virtualenv-ext.bash", shell_output("pyenv hooks which")
    assert_match "virtualenv-ext.bash", shell_output("pyenv hooks version-name")
  end
end
