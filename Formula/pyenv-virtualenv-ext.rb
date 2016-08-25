class PyenvVirtualenvExt < Formula
  desc "Make pyenv transparently aware of a virtual environment"
  homepage "https://github.com/jamieconnolly/pyenv-virtualenv-ext"
  url "https://github.com/jamieconnolly/pyenv-virtualenv-ext/archive/0.9.0.tar.gz"
  sha256 "e8ba418bd14c6349548f77a8f5ad7b3a63f3b3df640a9cb739ba32790e051d2f"

  head "https://github.com/jamieconnolly/pyenv-virtualenv-ext.git"

  bottle :unneeded

  depends_on "pyenv"
  depends_on "pyenv-virtualenv"

  def install
    ENV["PREFIX"] = prefix
    system "./install.sh"
  end

  test do
    assert_match "virtualenv-ext.bash", shell_output("pyenv hooks virtualenv")
    assert_match "virtualenv-ext.bash", shell_output("pyenv hooks which")
  end
end
