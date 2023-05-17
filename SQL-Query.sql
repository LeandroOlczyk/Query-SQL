CREATE SCHEMA `baseteste` ;

CREATE TABLE `baseteste`.`tab_produtos` (
  `idProduto` INT NOT NULL AUTO_INCREMENT,
  `nomeProduto` VARCHAR(50) NOT NULL,
  `unidadeMedida` VARCHAR(10) NOT NULL,
  `valorProduto` DOUBLE NOT NULL,
  PRIMARY KEY (`idProduto`),
  UNIQUE INDEX `idProduto_UNIQUE` (`idProduto` ASC) VISIBLE);

SELECT * FROM tab_produtos;

INSERT INTO `baseteste`.`tab_produtos` (`idProduto`, `nomeProduto`, `unidadeMedida`, `valorProduto`) VALUES ('1', 'ProdutoTeste1', 'UN', '50');
INSERT INTO `baseteste`.`tab_produtos` (`idProduto`, `nomeProduto`, `unidadeMedida`, `valorProduto`) VALUES ('2', 'ProdutoTeste2', 'PC', '75');
INSERT INTO `baseteste`.`tab_produtos` (`idProduto`, `nomeProduto`, `unidadeMedida`, `valorProduto`) VALUES ('3', 'ProdutoTeste3', 'PCT', '100');

UPDATE `baseteste`.`tab_produtos` SET `nomeProduto` = 'ProdutoTeste4' WHERE (`idProduto` = '3');

DELETE FROM tab_produtos WHERE idProduto=3;

DROP TABLE tab_produtos;