class PyenvVirtualenvExt < Formula
  desc "Make pyenv transparently aware of a virtual environment"
  homepage "https://github.com/jamieconnolly/pyenv-virtualenv-ext"
  url "https://github.com/jamieconnolly/pyenv-virtualenv-ext/archive/0.3.0.tar.gz"
  sha256 "5412fcf93abe8d2ad011d05343dbe4a4110ea42ae04c3a4e56e0f9e151fc3ff2"

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
    assert_match "virtualenv-ext.bash", shell_output("pyenv hooks which")
  end
end
