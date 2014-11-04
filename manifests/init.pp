class monitor inherits monitor::params {
  package { 'listen':
    ensure   => present,
    provider => $monitor::params::gem_provider,
  }
}
