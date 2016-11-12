class Handles < Formula
  desc "My plain, docile robot buddy"
  homepage "https://github.com/jamieconnolly/handles"
  url "https://github.com/jamieconnolly/handles/archive/f050f73d55309a5ac33b45f5aade88c15c06bbda.tar.gz"
  version "0.3"
  sha256 "d36fff4e7b7b71a8fdea9b7589f497bfc2cfa41e8f502e09da57862bf47d83f7"

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
