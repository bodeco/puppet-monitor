class monitor::params {
  if $::is_pe and $::osfamily != 'Windows' {
    $gem_provider = 'pe_gem'
  } else {
    $gem_provider = 'gem'
  }
}
