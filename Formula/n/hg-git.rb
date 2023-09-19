class HgGit < Formula
  include Language::Python::Virtualenv

  desc "Plugin for Mercurial, adding the ability to interact with git repositories"
  homepage "https://hg-git.github.io"
  license "GPL-2.0-or-later"

  stable do
    url "https://files.pythonhosted.org/packages/6f/ac/78a739bb37cf0f70db9cf115263b4e30daf5e35551d48a2a881d6b8894a4/hg-git-1.0.2.tar.gz"
    sha256 "5a840e87a70a15c9c1e06196bc3ed5955e772f11e9b1803e88c0c9f55af03416"
    # Fix compatibility with Mercurial > 6.4. Remove in next release.
    patch do
      url "https://foss.heptapod.net/mercurial/hg-git/-/commit/9a52223a95e9821b2f2b544ab5a35e06963da3f1.patch"
      sha256 "969f2900f0b4084fca21bc2368b82f5acef8f8241aa39e52501fd30264a5f59d"
    end
  end

  livecheck do
    url "https://files.pythonhosted.org/packages/6f/ac/78a739bb37cf0f70db9cf115263b4e30daf5e35551d48a2a881d6b8894a4/hg-git-1.0.2.tar.gz"
    strategy :pypi
  end

  head do
    # Nothing to do
  end

  depends_on "mercurial"
  depends_on "python@3.11"

  resource "dulwich" do
    url "https://files.pythonhosted.org/packages/57/e0/1b5f95c2651284a5d4fdfb2cc5ecad57fb694084cce59d9d4acb7ac30ecf/dulwich-0.21.6.tar.gz"
    sha256 "30fbe87e8b51f3813c131e2841c86d007434d160bd16db586b40d47f31dd05b0"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/31/ab/46bec149bbd71a4467a3063ac22f4486ecd2ceb70ae8c70d5d8e4c2a7946/urllib3-2.0.4.tar.gz"
    sha256 "8d22f86aae8ef5e410d4f539fde9ce6b2113a001bb4d189e0aed70642d602b11"
  end

  def install
    virtualenv_install_with_resources

    site_packages = Language::Python.site_packages("python3.11")
    (prefix/site_packages/"homebrew-#{@name}.pth").write libexec/site_packages
  end

  test do
    (testpath/".hgrc").write <<~EOS
      [extensions]
      hggit =
    EOS
    system "hg", "clone", "git+https://github.com/Homebrew/install.git"
  end
end
