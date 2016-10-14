class Handles < Formula
  desc "My plain, docile robot buddy"
  homepage "https://github.com/jamieconnolly/handles"
  url "https://github.com/jamieconnolly/handles/archive/fb6496c5f75e1cc6259a8716d4f693e6532d0708.tar.gz"
  version "0.0.1"
  sha256 "0676b544d6b2d4f29e0b07b629a015497e13008e8e5b5260250f7f8fa791a78e"

  head "https://github.com/jamieconnolly/handles.git"

  bottle :unneeded

  depends_on "glide" => :build
  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/jamieconnolly/handles").install buildpath.children
    cd "src/github.com/jamieconnolly/handles" do
      system "glide", "install"
      system "make", "build"
      bin.install "bin/handles"
      libexec.install Dir["libexec/*"]
      prefix.install_metafiles
    end
  end

  test do
    assert_match "Hello, World!", shell_output("#{bin}/handles example")
  end
end
