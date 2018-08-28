class Handles < Formula
  desc "My plain, docile robot buddy"
  homepage "https://github.com/jamieconnolly/handles"
  url "https://github.com/jamieconnolly/handles/archive/v24.tar.gz"
  sha256 "8553a465180ed12a7f265cadc158681f96ef5a1382f119b73b236ca482585a94"

  head "https://github.com/jamieconnolly/handles.git"

  option "without-completions", "Disable bash/zsh completions"

  depends_on "go" => :build

  depends_on "forego"
  depends_on "goenv"
  depends_on "hub"
  depends_on "nodenv"
  depends_on "pipenv"
  depends_on "pyenv"
  depends_on "rbenv"
  depends_on "yarn"

  def install
    ENV["GO111MODULE"] = "on"
    ENV["GOPATH"] = buildpath
    ENV["GOOS"] = "darwin"
    ENV["GOARCH"] = MacOS.prefer_64_bit? ? "amd64" : "386"

    (buildpath/"src/github.com/jamieconnolly/handles").install buildpath.children
    cd "src/github.com/jamieconnolly/handles" do
      system "make", "deps"
      system "make", "build", "VERSION=#{version}"

      bin.install Dir["bin/*"]
      libexec.install Dir["libexec/*"]
      prefix.install_metafiles

      if build.with? "completions"
        zsh_completion.install "completions/handles.zsh" => "_handles"
      end
    end
  end

  def caveats; <<~EOS
    In order to use Handles, please add the following to your $SHELL:
      export PROJECT_HOME="<Path to your projects folder>"
    EOS
  end

  test do
    assert_match "handles version #{version}", shell_output("#{bin}/handles --version")
  end
end
