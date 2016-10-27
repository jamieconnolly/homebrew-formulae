class Handles < Formula
  desc "My plain, docile robot buddy"
  homepage "https://github.com/jamieconnolly/handles"
  url "https://github.com/jamieconnolly/handles/archive/d07b18c2da8de5d8da925f0114c31931e39d3ee6.tar.gz"
  version "0.1.1"
  sha256 "104ba88a6a3f24754efdbd1efe0f97deacdaba6eb5a014ddedeafbf8e47774e0"

  head "https://github.com/jamieconnolly/handles.git"

  bottle :unneeded

  depends_on "glide" => :build
  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GLIDE_HOME"] = HOMEBREW_CACHE/"glide_home/#{name}"

    (buildpath/"src/github.com/jamieconnolly/handles").install buildpath.children
    cd "src/github.com/jamieconnolly/handles" do
      system "glide", "install"
      system "make", "build", "VERSION=#{version}"

      bin.install Dir["bin/*"]
      libexec.install Dir["libexec/*"]
      prefix.install_metafiles
    end
  end

  test do
    assert_match "handles version #{version}", shell_output("#{bin}/handles --version")
  end
end
