class Handles < Formula
  desc "My plain, docile robot buddy"
  homepage "https://github.com/jamieconnolly/handles"
  url "https://github.com/jamieconnolly/handles/archive/v11.tar.gz"
  sha256 "761135274fda002c314aa03f6ff2a548a364a6dfb93b741a6cdd5de3c39c7021"

  head "https://github.com/jamieconnolly/handles.git"

  bottle :unneeded

  option "without-completions", "Disable bash/zsh completions"

  depends_on "go" => :build

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
      export GITHUB_USER="<Your GitHub username>"
      export PROJECTS_HOME="<Path to your projects folder>"
    EOS
  end

  test do
    assert_match "handles version #{version}", shell_output("#{bin}/handles --version")
  end
end
