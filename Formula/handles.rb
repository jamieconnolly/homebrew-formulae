class Handles < Formula
  desc "My plain, docile robot buddy"
  homepage "https://github.com/jamieconnolly/handles"
  url "https://github.com/jamieconnolly/handles/archive/v19.tar.gz"
  sha256 "b519450fd4dee81e6164f2279a5a862735ba0eb5dd403bf532aa3f14807fd0c6"

  head "https://github.com/jamieconnolly/handles.git"

  option "without-completions", "Disable bash/zsh completions"

  depends_on "go" => :build

  depends_on "dep" => :run
  depends_on "forego" => :run
  depends_on "goenv" => :run
  depends_on "nodenv" => :run
  depends_on "pipenv" => :run
  depends_on "pyenv" => :run
  depends_on "rbenv" => :run
  depends_on "yarn" => :run

  def install
    ENV["GOPATH"] = buildpath
    ENV["GOOS"] = "darwin"
    ENV["GOARCH"] = MacOS.prefer_64_bit? ? "amd64" : "386"

    (buildpath/"src/github.com/jamieconnolly/handles").install buildpath.children
    cd "src/github.com/jamieconnolly/handles" do
      system "make", "build", "VERSION=#{version}"

      bin.install Dir["bin/*"]
      libexec.install Dir["libexec/*"]
      prefix.install_metafiles

      if build.with? "completions"
        zsh_completion.install "completions/handles.zsh" => "_handles"
      end
    end
  end

  def caveats; <<-EOS.undent
    In order to use Handles, please add the following to your $SHELL:
      export PROJECT_HOME="<Path to your projects folder>"
    EOS
  end

  test do
    assert_match "handles version #{version}", shell_output("#{bin}/handles --version")
  end
end
