class HgEvolve < Formula
  include Language::Python::Virtualenv

  desc "Mercurial extension for faster and safer mutable history"
  homepage "https://www.mercurial-scm.org/doc/evolution/user-guide.html"
  license "GPL-2.0-or-later"

  revision 1

  stable do
    url "https://files.pythonhosted.org/packages/b2/ec/986120fab219b21158aeed208a7e60122a59b12ef8151d2c3d44520b64a1/hg-evolve-11.1.0.tar.gz"
    sha256 "b0cbc7bc7c0bb8c4f42da1f65c50de3ee78f6f00978ef97ae9019d11147493a8"
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

  def install
    virtualenv_install_with_resources

    site_packages = Language::Python.site_packages("python3.12")
    (prefix/site_packages/"homebrew-#{@name}.pth").write libexec/site_packages
  end

  test do
    (testpath/".hgrc").write <<~EOS
      [extensions]
      evolve =
    EOS
    system "hg", "help", "evolve", "--pager=none"
  end
end
