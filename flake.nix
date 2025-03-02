{
  description = "Flake template by Iliyan Kostov";

  outputs = { self }: {
    templates = {

      java = {
        path = ./templates/flake-parts/java;
        description = "Java flake template";
      };

      python = {
        path = ./templates/flake-parts/python;
        description = "Python flake template";
      };

      javascript = {
        path = ./templates/flake-parts/javascript;
        description = "Javascript flake template";
      };

    };
  };
}
