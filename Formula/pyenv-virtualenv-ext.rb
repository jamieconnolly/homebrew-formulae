class PyenvVirtualenvExt < Formula
  desc "Make pyenv transparently aware of a virtual environment"
  homepage "https://github.com/jamieconnolly/pyenv-virtualenv-ext"
  url "https://github.com/jamieconnolly/pyenv-virtualenv-ext/archive/0.2.0.tar.gz"
  sha256 "50ad2a103a58a27d663adf1a042ad36a0c565d051281d728a876e11d722945f5"

  head "https://github.com/jamieconnolly/pyenv-virtualenv-ext.git"

  bottle :unneeded

  depends_on "pyenv"
  depends_on "pyenv-virtualenv"

  def install
    ENV["PREFIX"] = prefix
    system "./install.sh"
  end

  test do
    assert_match "virtualenv-ext.bash", shell_output("pyenv hooks which")
    assert_match "virtualenv-ext.bash", shell_output("pyenv hooks version-name")
  end
end
