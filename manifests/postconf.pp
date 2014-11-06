define postfix::postconf (
  $key = '',
  $value,
) {

  $real_key = $key?{
    ''      => $name,
    default => $key
  }

  $key_value = "${real_key}=${value}"

  $stripped_value=regsubst($value,'\ ','')
  $stripped_keyvalue = "${real_key}=${stripped_value}"

  exec{"postconf_${real_key}":
    command => "postconf -e '${key_value}'",
    unless  => "test \"\$(postconf ${real_key} | sed -e 's/\\ //g')\" = '$stripped_keyvalue'",
    path    => $::path
  }
}
