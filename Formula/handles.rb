class Handles < Formula
  desc "My plain, docile robot buddy"
  homepage "https://github.com/jamieconnolly/handles"
  url "https://github.com/jamieconnolly/handles/archive/v14.tar.gz"
  sha256 "b3af176c50d1222a52bf9f3fa6b60474211a98087bd684b30251757988b81036"

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
      export PROJECT_HOME="<Path to your projects folder>"
    EOS
  end

  test do
    assert_match "handles version #{version}", shell_output("#{bin}/handles --version")
  end
end
