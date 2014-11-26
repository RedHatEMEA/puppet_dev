#Creates repositories
define puppet_dev::create_repos {
  vcsrepo { "${puppet_dev::repo_path}/${name}":
    ensure   => present,
    provider => git,
    source   => $name,
  }
}
