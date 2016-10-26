class Handles < Formula
  desc "My plain, docile robot buddy"
  homepage "https://github.com/jamieconnolly/handles"
  url "https://github.com/jamieconnolly/handles/archive/e5efe0604e73bc7ee11ccdcf5cdad6ecabc323c4.tar.gz"
  version "0.0.2"
  sha256 "44a3ba2db9bcd29a6aedb1bf191e6116c38757995b3a4e44af01bc586ed947a0"

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
      system "make", "build"
      bin.install Dir["bin/*"]
      libexec.install Dir["libexec/*"]
      prefix.install_metafiles
    end
  end

  test do
    assert_match "Hello, World!", shell_output("#{bin}/handles example")
  end
end
