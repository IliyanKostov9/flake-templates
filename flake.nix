{
  description = "Flake template by Iliyan Kostov";

  outputs = { self }: {
    templates = {
      java = {
        path = ./templates/flake-parts/java;
        description = "Java flake template";
      };
    };
  };
}
