class HgGit < Formula
  include Language::Python::Virtualenv

  desc "Plugin for Mercurial, adding the ability to interact with git repositories"
  homepage "https://hg-git.github.io"
  license "GPL-2.0-or-later"

  revision 1

  stable do
    url "https://files.pythonhosted.org/packages/41/9a/e8d24706580160636df8380763f81852a635a438a4a2f053d59ace54d3ca/hg-git-1.0.3.tar.gz"
    sha256 "1ee170456fd2b86af3317f5bb6d76aced151075f5d659345e58f3e7bd800416c"
  end

  livecheck do
    url :stable
    strategy :pypi
  end

  head do
    # Nothing to do
  end

  depends_on "mercurial"
  depends_on "python@3.12"

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

    site_packages = Language::Python.site_packages("python3.12")
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
