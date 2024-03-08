class HgGit < Formula
  include Language::Python::Virtualenv

  desc "Plugin for Mercurial, adding the ability to interact with git repositories"
  homepage "https://hg-git.github.io"
  license "GPL-2.0-or-later"

  stable do
    url "https://files.pythonhosted.org/packages/7a/8a/cdaa0e41e0298db7c88c1bd9d16c00b89bb9f3e194005a78a6f81a2ac104/hg-git-1.1.1.tar.gz"
    sha256 "af4e10eb36edf153358d892818e74966a28f3f15f2e230b55f577d9c9f9f1166"

    depends_on "mercurial"
    depends_on "python@3.12"
  end

  livecheck do
    url :stable
    strategy :pypi
  end

  head do
    # Nothing to do
  end

  resource "dulwich" do
    url "https://files.pythonhosted.org/packages/2b/e2/788910715b4910d08725d480278f625e315c3c011eb74b093213363042e0/dulwich-0.21.7.tar.gz"
    sha256 "a9e9c66833cea580c3ac12927e4b9711985d76afca98da971405d414de60e968"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/e2/cc/abf6746cc90bc52df4ba730f301b89b3b844d6dc133cb89a01cfe2511eb9/urllib3-2.2.0.tar.gz"
    sha256 "051d961ad0c62a94e50ecf1af379c3aba230c66c710493493560c0c223c49f20"
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
