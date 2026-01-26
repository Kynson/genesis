{
  services.coredns = {
    enable = true;
    config = ''
      . {
        template IN A .local {
          match ^(?P<d>[0-9]*)[.](?P<c>[0-9]*)[.](?P<b>[0-9]*)[.](?P<a>[0-9]*)[.]local$
          answer "{{ .Name }} 60 IN A {{ .Group.a }}.{{ .Group.b }}.{{ .Group.c }}.{{ .Group.d }}"
        }

        forward . 1.1.1.1 1.0.0.1 8.8.8.8
      }
    '';
  };
}