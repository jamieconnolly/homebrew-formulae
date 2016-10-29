class Handles < Formula
  desc "My plain, docile robot buddy"
  homepage "https://github.com/jamieconnolly/handles"
  url "https://github.com/jamieconnolly/handles/archive/e345001ef6c8d2a454d637e0e977c1cc77ef06a3.tar.gz"
  version "0.2"
  sha256 "fbe8a4531a58e4e2e8564235e858c6aa78dd2c2599e0877cbae5b589caa1673f"

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
