Build started...
Build succeeded.
DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM pg_namespace WHERE nspname = 'weges') THEN
        CREATE SCHEMA weges;
    END IF;
END $EF$;
CREATE TABLE IF NOT EXISTS weges."__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL,
    CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId")
);

START TRANSACTION;

CREATE TABLE "Estabelecimentos" (
    "Id" bigint GENERATED BY DEFAULT AS IDENTITY,
    "Sigla" text NOT NULL,
    "Denominacao" text NOT NULL,
    "Morada" text NOT NULL,
    "Email" text NOT NULL,
    "Telefone" text NOT NULL,
    "TipoPrestador" text NOT NULL,
    "Created" timestamp with time zone NOT NULL,
    "CreatedBy" text NOT NULL,
    "Modified" timestamp with time zone NOT NULL,
    "ModifiedBy" text NOT NULL,
    CONSTRAINT "PK_Estabelecimentos" PRIMARY KEY ("Id")
);

INSERT INTO weges."__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20241114043245_init-mig', '8.0.12');

COMMIT;

START TRANSACTION;

ALTER TABLE "Estabelecimentos" ALTER COLUMN "TipoPrestador" DROP NOT NULL;

ALTER TABLE "Estabelecimentos" ALTER COLUMN "Telefone" DROP NOT NULL;

ALTER TABLE "Estabelecimentos" ALTER COLUMN "Sigla" DROP NOT NULL;

ALTER TABLE "Estabelecimentos" ALTER COLUMN "Morada" DROP NOT NULL;

ALTER TABLE "Estabelecimentos" ALTER COLUMN "Email" DROP NOT NULL;

ALTER TABLE "Estabelecimentos" ADD "InicioAtividade" date NOT NULL DEFAULT DATE '-infinity';

CREATE TABLE "Entidades" (
    "Id" bigint GENERATED BY DEFAULT AS IDENTITY,
    "Denominacao" text,
    "Morada" text,
    "NifNipc" text NOT NULL,
    "Telefone" text,
    "Email" text,
    "Sigla" text,
    "NrERS" integer NOT NULL,
    "EmailNotificacoesERS" text,
    "EmailNotificacoesGerais" text,
    "CodCaeId" text,
    "Created" timestamp with time zone NOT NULL,
    "CreatedBy" text NOT NULL,
    "Modified" timestamp with time zone NOT NULL,
    "ModifiedBy" text NOT NULL,
    CONSTRAINT "PK_Entidades" PRIMARY KEY ("Id")
);

CREATE TABLE "CodCaes" (
    "Id" bigint GENERATED BY DEFAULT AS IDENTITY,
    "Codigo" text NOT NULL,
    "Designacao" text NOT NULL,
    "EntidadeId" bigint NOT NULL,
    "Created" timestamp with time zone NOT NULL,
    "CreatedBy" text NOT NULL,
    "Modified" timestamp with time zone NOT NULL,
    "ModifiedBy" text NOT NULL,
    CONSTRAINT "PK_CodCaes" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_CodCaes_Entidades_EntidadeId" FOREIGN KEY ("EntidadeId") REFERENCES "Entidades" ("Id") ON DELETE CASCADE
);

CREATE INDEX "IX_CodCaes_EntidadeId" ON "CodCaes" ("EntidadeId");

INSERT INTO weges."__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20241126030356_aLotOfStuff', '8.0.12');

COMMIT;

START TRANSACTION;

ALTER TABLE "Entidades" DROP COLUMN "CodCaeId";

INSERT INTO weges."__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20241126031031_codCaesM2M', '8.0.12');

COMMIT;

START TRANSACTION;

ALTER TABLE "CodCaes" DROP CONSTRAINT "FK_CodCaes_Entidades_EntidadeId";

DROP INDEX "IX_CodCaes_EntidadeId";

ALTER TABLE "CodCaes" DROP COLUMN "EntidadeId";

CREATE TABLE "CodCaeEntidade" (
    "CodCaesId" bigint NOT NULL,
    "EntidadesId" bigint NOT NULL,
    CONSTRAINT "PK_CodCaeEntidade" PRIMARY KEY ("CodCaesId", "EntidadesId"),
    CONSTRAINT "FK_CodCaeEntidade_CodCaes_CodCaesId" FOREIGN KEY ("CodCaesId") REFERENCES "CodCaes" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_CodCaeEntidade_Entidades_EntidadesId" FOREIGN KEY ("EntidadesId") REFERENCES "Entidades" ("Id") ON DELETE CASCADE
);

CREATE INDEX "IX_CodCaeEntidade_EntidadesId" ON "CodCaeEntidade" ("EntidadesId");

INSERT INTO weges."__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20241126031340_codCaesM2M2', '8.0.12');

COMMIT;

START TRANSACTION;

INSERT INTO weges."__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20241126234442_entidadeECodCae', '8.0.12');

COMMIT;

START TRANSACTION;

ALTER TABLE "Estabelecimentos" ALTER COLUMN "ModifiedBy" DROP NOT NULL;

ALTER TABLE "Estabelecimentos" ALTER COLUMN "CreatedBy" DROP NOT NULL;

ALTER TABLE "Entidades" ALTER COLUMN "Telefone" TYPE character varying(9);

ALTER TABLE "Entidades" ALTER COLUMN "Sigla" TYPE character varying(8);

ALTER TABLE "Entidades" ALTER COLUMN "NrERS" TYPE text;
ALTER TABLE "Entidades" ALTER COLUMN "NrERS" DROP NOT NULL;

ALTER TABLE "Entidades" ALTER COLUMN "NifNipc" TYPE character varying(9);

ALTER TABLE "Entidades" ALTER COLUMN "Morada" TYPE character varying(200);

ALTER TABLE "Entidades" ALTER COLUMN "ModifiedBy" DROP NOT NULL;
ALTER TABLE "Entidades" ALTER COLUMN "ModifiedBy" SET DEFAULT 'system-usr';

ALTER TABLE "Entidades" ALTER COLUMN "Modified" SET DEFAULT (NOW());

ALTER TABLE "Entidades" ALTER COLUMN "EmailNotificacoesGerais" TYPE character varying(50);

ALTER TABLE "Entidades" ALTER COLUMN "EmailNotificacoesERS" TYPE character varying(50);

ALTER TABLE "Entidades" ALTER COLUMN "Email" TYPE character varying(50);

ALTER TABLE "Entidades" ALTER COLUMN "Denominacao" TYPE character varying(200);

ALTER TABLE "Entidades" ALTER COLUMN "CreatedBy" DROP NOT NULL;
ALTER TABLE "Entidades" ALTER COLUMN "CreatedBy" SET DEFAULT 'system-usr';

ALTER TABLE "Entidades" ALTER COLUMN "Created" SET DEFAULT (NOW());

ALTER TABLE "CodCaes" ALTER COLUMN "ModifiedBy" DROP NOT NULL;

ALTER TABLE "CodCaes" ALTER COLUMN "CreatedBy" DROP NOT NULL;

INSERT INTO weges."__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20241127014602_configsEF', '8.0.12');

COMMIT;

START TRANSACTION;

INSERT INTO "Entidades" ("Id", "Denominacao", "Email", "EmailNotificacoesERS", "EmailNotificacoesGerais", "Morada", "NifNipc", "NrERS", "Sigla", "Telefone")
VALUES (1, 'Teste 1', 'emailteste@email.email', 'emailnotificacoes@email.email', 'emailnotificacoes@email.email', 'Rua do Teste 1', '123123123', 'A-1234', 'TsT1', '921111111');
INSERT INTO "Entidades" ("Id", "Denominacao", "Email", "EmailNotificacoesERS", "EmailNotificacoesGerais", "Morada", "NifNipc", "NrERS", "Sigla", "Telefone")
VALUES (2, 'Teste 2', 'emailteste@email.email', 'emailnotificacoes@email.email', 'emailnotificacoes@email.email', 'Rua do Teste 2', '123123123', 'A-1234', 'TsT2', '921111111');

SELECT setval(
    pg_get_serial_sequence('"Entidades"', 'Id'),
    GREATEST(
        (SELECT MAX("Id") FROM "Entidades") + 1,
        nextval(pg_get_serial_sequence('"Entidades"', 'Id'))),
    false);

INSERT INTO weges."__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20241202221302_data', '8.0.12');

COMMIT;

START TRANSACTION;

CREATE TABLE "AspNetRoles" (
    "Id" text NOT NULL,
    "Name" character varying(256),
    "NormalizedName" character varying(256),
    "ConcurrencyStamp" text,
    CONSTRAINT "PK_AspNetRoles" PRIMARY KEY ("Id")
);

CREATE TABLE "AspNetUsers" (
    "Id" text NOT NULL,
    "UserName" character varying(256),
    "NormalizedUserName" character varying(256),
    "Email" character varying(256),
    "NormalizedEmail" character varying(256),
    "EmailConfirmed" boolean NOT NULL,
    "PasswordHash" text,
    "SecurityStamp" text,
    "ConcurrencyStamp" text,
    "PhoneNumber" text,
    "PhoneNumberConfirmed" boolean NOT NULL,
    "TwoFactorEnabled" boolean NOT NULL,
    "LockoutEnd" timestamp with time zone,
    "LockoutEnabled" boolean NOT NULL,
    "AccessFailedCount" integer NOT NULL,
    CONSTRAINT "PK_AspNetUsers" PRIMARY KEY ("Id")
);

CREATE TABLE "AspNetRoleClaims" (
    "Id" integer GENERATED BY DEFAULT AS IDENTITY,
    "RoleId" text NOT NULL,
    "ClaimType" text,
    "ClaimValue" text,
    CONSTRAINT "PK_AspNetRoleClaims" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_AspNetRoleClaims_AspNetRoles_RoleId" FOREIGN KEY ("RoleId") REFERENCES "AspNetRoles" ("Id") ON DELETE CASCADE
);

CREATE TABLE "AspNetUserClaims" (
    "Id" integer GENERATED BY DEFAULT AS IDENTITY,
    "UserId" text NOT NULL,
    "ClaimType" text,
    "ClaimValue" text,
    CONSTRAINT "PK_AspNetUserClaims" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_AspNetUserClaims_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers" ("Id") ON DELETE CASCADE
);

CREATE TABLE "AspNetUserLogins" (
    "LoginProvider" text NOT NULL,
    "ProviderKey" text NOT NULL,
    "ProviderDisplayName" text,
    "UserId" text NOT NULL,
    CONSTRAINT "PK_AspNetUserLogins" PRIMARY KEY ("LoginProvider", "ProviderKey"),
    CONSTRAINT "FK_AspNetUserLogins_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers" ("Id") ON DELETE CASCADE
);

CREATE TABLE "AspNetUserRoles" (
    "UserId" text NOT NULL,
    "RoleId" text NOT NULL,
    CONSTRAINT "PK_AspNetUserRoles" PRIMARY KEY ("UserId", "RoleId"),
    CONSTRAINT "FK_AspNetUserRoles_AspNetRoles_RoleId" FOREIGN KEY ("RoleId") REFERENCES "AspNetRoles" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_AspNetUserRoles_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers" ("Id") ON DELETE CASCADE
);

CREATE TABLE "AspNetUserTokens" (
    "UserId" text NOT NULL,
    "LoginProvider" text NOT NULL,
    "Name" text NOT NULL,
    "Value" text,
    CONSTRAINT "PK_AspNetUserTokens" PRIMARY KEY ("UserId", "LoginProvider", "Name"),
    CONSTRAINT "FK_AspNetUserTokens_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers" ("Id") ON DELETE CASCADE
);

CREATE INDEX "IX_AspNetRoleClaims_RoleId" ON "AspNetRoleClaims" ("RoleId");

CREATE UNIQUE INDEX "RoleNameIndex" ON "AspNetRoles" ("NormalizedName");

CREATE INDEX "IX_AspNetUserClaims_UserId" ON "AspNetUserClaims" ("UserId");

CREATE INDEX "IX_AspNetUserLogins_UserId" ON "AspNetUserLogins" ("UserId");

CREATE INDEX "IX_AspNetUserRoles_RoleId" ON "AspNetUserRoles" ("RoleId");

CREATE INDEX "EmailIndex" ON "AspNetUsers" ("NormalizedEmail");

CREATE UNIQUE INDEX "UserNameIndex" ON "AspNetUsers" ("NormalizedUserName");

INSERT INTO weges."__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20241219111821_AddedIdentity', '8.0.12');

COMMIT;

START TRANSACTION;

DROP TABLE "AspNetRoleClaims";

DROP TABLE "AspNetUserClaims";

DROP TABLE "AspNetUserLogins";

DROP TABLE "AspNetUserRoles";

DROP TABLE "AspNetUserTokens";

DROP TABLE "AspNetRoles";

DROP TABLE "AspNetUsers";

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM pg_namespace WHERE nspname = 'weges') THEN
        CREATE SCHEMA weges;
    END IF;
END $EF$;

ALTER TABLE "Estabelecimentos" SET SCHEMA weges;

ALTER TABLE "Entidades" SET SCHEMA weges;

ALTER TABLE "CodCaes" SET SCHEMA weges;

ALTER TABLE "CodCaeEntidade" SET SCHEMA weges;

INSERT INTO weges."__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20241227221456_UsersInit', '8.0.12');

COMMIT;

START TRANSACTION;

UPDATE weges."Entidades" SET "Denominacao" = 'Entidade 1', "Sigla" = 'ent1'
WHERE "Id" = 1;

UPDATE weges."Entidades" SET "Denominacao" = 'Entidade 2', "Sigla" = 'ent2'
WHERE "Id" = 2;

INSERT INTO weges."Estabelecimentos" ("Id", "Created", "CreatedBy", "Denominacao", "Email", "InicioAtividade", "Modified", "ModifiedBy", "Morada", "Sigla", "Telefone", "TipoPrestador")
VALUES (1, TIMESTAMPTZ '-infinity', NULL, 'Estabelecimento 1', 'email@email.email', DATE '2020-02-20', TIMESTAMPTZ '-infinity', NULL, 'estab 1 morada', 'estab1', '291111111', 'Tipo de Prestador');
INSERT INTO weges."Estabelecimentos" ("Id", "Created", "CreatedBy", "Denominacao", "Email", "InicioAtividade", "Modified", "ModifiedBy", "Morada", "Sigla", "Telefone", "TipoPrestador")
VALUES (2, TIMESTAMPTZ '-infinity', NULL, 'Estabelecimento 2', 'email@email.email', DATE '2023-02-20', TIMESTAMPTZ '-infinity', NULL, 'estab 2 morada', 'estab2', '291111112', 'Tipo de Prestador');

SELECT setval(
    pg_get_serial_sequence('weges."Estabelecimentos"', 'Id'),
    GREATEST(
        (SELECT MAX("Id") FROM weges."Estabelecimentos") + 1,
        nextval(pg_get_serial_sequence('weges."Estabelecimentos"', 'Id'))),
    false);

INSERT INTO weges."__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20250101205630_AddedEstabsExemplo', '8.0.12');

COMMIT;

START TRANSACTION;

CREATE TABLE weges."DirecoesClinicas" (
    "Id" bigint GENERATED BY DEFAULT AS IDENTITY,
    "Nome" text,
    "Cargo" text,
    "Identificacao" text,
    "ValidadeIdentificacao" date NOT NULL,
    "Cedula" text,
    "Ordem" text,
    "Especialidade" text,
    "EspecialidadeId" bigint NOT NULL,
    "Observacoes" text,
    "EstabelecimentoId" bigint NOT NULL,
    "TipologiaId" bigint NOT NULL,
    "Tipologia" text,
    "Created" timestamp with time zone NOT NULL,
    "CreatedBy" text,
    "Modified" timestamp with time zone NOT NULL,
    "ModifiedBy" text,
    CONSTRAINT "PK_DirecoesClinicas" PRIMARY KEY ("Id")
);

INSERT INTO weges."DirecoesClinicas" ("Id", "Cargo", "Cedula", "Created", "CreatedBy", "Especialidade", "EspecialidadeId", "EstabelecimentoId", "Identificacao", "Modified", "ModifiedBy", "Nome", "Observacoes", "Ordem", "Tipologia", "TipologiaId", "ValidadeIdentificacao")
VALUES (1, 'Cargo 1', 'Cedula 1', TIMESTAMPTZ '-infinity', NULL, 'Especialidade 1', 1, 1, 'Identificacao 1', TIMESTAMPTZ '-infinity', NULL, 'Nome 1', 'Observacoes 1', 'Ordem 1', 'Tipologia 1', 1, DATE '2023-02-20');
INSERT INTO weges."DirecoesClinicas" ("Id", "Cargo", "Cedula", "Created", "CreatedBy", "Especialidade", "EspecialidadeId", "EstabelecimentoId", "Identificacao", "Modified", "ModifiedBy", "Nome", "Observacoes", "Ordem", "Tipologia", "TipologiaId", "ValidadeIdentificacao")
VALUES (2, 'Cargo 2', 'Cedula 2', TIMESTAMPTZ '-infinity', NULL, 'Especialidade 2', 2, 2, 'Identificacao 2', TIMESTAMPTZ '-infinity', NULL, 'Nome 2', 'Observacoes 2', 'Ordem 2', 'Tipologia 2', 2, DATE '2023-02-20');

SELECT setval(
    pg_get_serial_sequence('weges."DirecoesClinicas"', 'Id'),
    GREATEST(
        (SELECT MAX("Id") FROM weges."DirecoesClinicas") + 1,
        nextval(pg_get_serial_sequence('weges."DirecoesClinicas"', 'Id'))),
    false);

INSERT INTO weges."__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20250101211436_AddedDirecaoClinicaExemplo', '8.0.12');

COMMIT;

START TRANSACTION;

CREATE TABLE weges."Servicos" (
    "Id" bigint GENERATED BY DEFAULT AS IDENTITY,
    "Nome" text,
    "DataInicio" date,
    "Responsavel" text,
    "TipologiaId" bigint NOT NULL,
    "Horario" text,
    "Observacoes" text,
    "EstabelecimentoId" bigint NOT NULL,
    "Tipologia" text,
    "Created" timestamp with time zone NOT NULL,
    "CreatedBy" text,
    "Modified" timestamp with time zone NOT NULL,
    "ModifiedBy" text,
    CONSTRAINT "PK_Servicos" PRIMARY KEY ("Id")
);

INSERT INTO weges."Servicos" ("Id", "Created", "CreatedBy", "DataInicio", "EstabelecimentoId", "Horario", "Modified", "ModifiedBy", "Nome", "Observacoes", "Responsavel", "Tipologia", "TipologiaId")
VALUES (1, TIMESTAMPTZ '-infinity', NULL, DATE '2023-02-20', 1, 'Horario 1', TIMESTAMPTZ '-infinity', NULL, 'Servico 1', 'Observacoes 1', 'Responsavel 1', 'Tipologia 1', 1);
INSERT INTO weges."Servicos" ("Id", "Created", "CreatedBy", "DataInicio", "EstabelecimentoId", "Horario", "Modified", "ModifiedBy", "Nome", "Observacoes", "Responsavel", "Tipologia", "TipologiaId")
VALUES (2, TIMESTAMPTZ '-infinity', NULL, DATE '2023-02-20', 2, 'Horario 2', TIMESTAMPTZ '-infinity', NULL, 'Servico 2', 'Observacoes 2', 'Responsavel 2', 'Tipologia 2', 2);

SELECT setval(
    pg_get_serial_sequence('weges."Servicos"', 'Id'),
    GREATEST(
        (SELECT MAX("Id") FROM weges."Servicos") + 1,
        nextval(pg_get_serial_sequence('weges."Servicos"', 'Id'))),
    false);

INSERT INTO weges."__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20250101233140_AddedServicos', '8.0.12');

COMMIT;

START TRANSACTION;

DELETE FROM weges."DirecoesClinicas"
WHERE "Id" = 1;

DELETE FROM weges."DirecoesClinicas"
WHERE "Id" = 2;

DELETE FROM weges."Entidades"
WHERE "Id" = 1;

DELETE FROM weges."Entidades"
WHERE "Id" = 2;

DELETE FROM weges."Estabelecimentos"
WHERE "Id" = 1;

DELETE FROM weges."Estabelecimentos"
WHERE "Id" = 2;

DELETE FROM weges."Servicos"
WHERE "Id" = 1;

DELETE FROM weges."Servicos"
WHERE "Id" = 2;

ALTER TABLE weges."Servicos" ALTER COLUMN "ModifiedBy" SET DEFAULT 'system-usr';

ALTER TABLE weges."Servicos" ALTER COLUMN "Modified" SET DEFAULT (NOW());

ALTER TABLE weges."Servicos" ALTER COLUMN "CreatedBy" SET DEFAULT 'system-usr';

ALTER TABLE weges."Servicos" ALTER COLUMN "Created" SET DEFAULT (NOW());

ALTER TABLE weges."Estabelecimentos" ALTER COLUMN "ModifiedBy" SET DEFAULT 'system-usr';

ALTER TABLE weges."Estabelecimentos" ALTER COLUMN "Modified" SET DEFAULT (NOW());

ALTER TABLE weges."Estabelecimentos" ALTER COLUMN "CreatedBy" SET DEFAULT 'system-usr';

ALTER TABLE weges."Estabelecimentos" ALTER COLUMN "Created" SET DEFAULT (NOW());

ALTER TABLE weges."DirecoesClinicas" ALTER COLUMN "ModifiedBy" SET DEFAULT 'system-usr';

ALTER TABLE weges."DirecoesClinicas" ALTER COLUMN "Modified" SET DEFAULT (NOW());

ALTER TABLE weges."DirecoesClinicas" ALTER COLUMN "CreatedBy" SET DEFAULT 'system-usr';

ALTER TABLE weges."DirecoesClinicas" ALTER COLUMN "Created" SET DEFAULT (NOW());

INSERT INTO weges."__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20250103005217_MassiveChanges', '8.0.12');

COMMIT;

START TRANSACTION;

CREATE TABLE weges."Ficheiros" (
    "Id" bigint GENERATED BY DEFAULT AS IDENTITY,
    "Nome" text,
    "Localizacao" text,
    "Tipo" text,
    "Created" timestamp with time zone NOT NULL DEFAULT (NOW()),
    "CreatedBy" text DEFAULT 'system-usr',
    "Modified" timestamp with time zone NOT NULL DEFAULT (NOW()),
    "ModifiedBy" text DEFAULT 'system-usr',
    CONSTRAINT "PK_Ficheiros" PRIMARY KEY ("Id")
);

CREATE TABLE weges."CertificadosERS" (
    "Id" bigint GENERATED BY DEFAULT AS IDENTITY,
    "Periodo" text,
    "NrCertificado" text,
    "DataSubmissao" date,
    "DataExpiracao" date,
    "Observacoes" text,
    "DataExpiracaoTaxa" date,
    "DataPagamentoTaxa" date,
    "EstabelecimentoId" bigint NOT NULL,
    "FicheiroId" bigint,
    "Created" timestamp with time zone NOT NULL DEFAULT (NOW()),
    "CreatedBy" text DEFAULT 'system-usr',
    "Modified" timestamp with time zone NOT NULL DEFAULT (NOW()),
    "ModifiedBy" text DEFAULT 'system-usr',
    CONSTRAINT "PK_CertificadosERS" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_CertificadosERS_Estabelecimentos_EstabelecimentoId" FOREIGN KEY ("EstabelecimentoId") REFERENCES weges."Estabelecimentos" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_CertificadosERS_Ficheiros_FicheiroId" FOREIGN KEY ("FicheiroId") REFERENCES weges."Ficheiros" ("Id") ON DELETE SET NULL
);

CREATE TABLE weges."LicencasERS" (
    "Id" bigint GENERATED BY DEFAULT AS IDENTITY,
    "Periodo" text,
    "NrLicenca" text,
    "DataSubmissao" date,
    "Observacoes" text,
    "FicheiroId" bigint,
    "EstabelecimentoId" bigint NOT NULL,
    "Created" timestamp with time zone NOT NULL DEFAULT (NOW()),
    "CreatedBy" text DEFAULT 'system-usr',
    "Modified" timestamp with time zone NOT NULL DEFAULT (NOW()),
    "ModifiedBy" text DEFAULT 'system-usr',
    CONSTRAINT "PK_LicencasERS" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_LicencasERS_Estabelecimentos_EstabelecimentoId" FOREIGN KEY ("EstabelecimentoId") REFERENCES weges."Estabelecimentos" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_LicencasERS_Ficheiros_FicheiroId" FOREIGN KEY ("FicheiroId") REFERENCES weges."Ficheiros" ("Id")
);

CREATE UNIQUE INDEX "IX_CertificadosERS_EstabelecimentoId" ON weges."CertificadosERS" ("EstabelecimentoId");

CREATE INDEX "IX_CertificadosERS_FicheiroId" ON weges."CertificadosERS" ("FicheiroId");

CREATE UNIQUE INDEX "IX_LicencasERS_EstabelecimentoId" ON weges."LicencasERS" ("EstabelecimentoId");

CREATE INDEX "IX_LicencasERS_FicheiroId" ON weges."LicencasERS" ("FicheiroId");

INSERT INTO weges."__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20250110032124_AddedCertLicFicheiros', '8.0.12');

COMMIT;

START TRANSACTION;

ALTER TABLE weges."LicencasERS" DROP CONSTRAINT "FK_LicencasERS_Ficheiros_FicheiroId";

ALTER TABLE weges."Servicos" DROP COLUMN "Tipologia";

ALTER TABLE weges."DirecoesClinicas" DROP COLUMN "Tipologia";

ALTER TABLE weges."Servicos" ALTER COLUMN "TipologiaId" DROP NOT NULL;

ALTER TABLE weges."DirecoesClinicas" ALTER COLUMN "TipologiaId" DROP NOT NULL;

CREATE TABLE weges."Tipologias" (
    "Id" bigint GENERATED BY DEFAULT AS IDENTITY,
    "Nome" text NOT NULL,
    "Created" timestamp with time zone NOT NULL,
    "CreatedBy" text,
    "Modified" timestamp with time zone NOT NULL,
    "ModifiedBy" text,
    CONSTRAINT "PK_Tipologias" PRIMARY KEY ("Id")
);

CREATE INDEX "IX_Servicos_TipologiaId" ON weges."Servicos" ("TipologiaId");

CREATE INDEX "IX_DirecoesClinicas_TipologiaId" ON weges."DirecoesClinicas" ("TipologiaId");

ALTER TABLE weges."DirecoesClinicas" ADD CONSTRAINT "FK_DirecoesClinicas_Tipologias_TipologiaId" FOREIGN KEY ("TipologiaId") REFERENCES weges."Tipologias" ("Id") ON DELETE SET NULL;

ALTER TABLE weges."LicencasERS" ADD CONSTRAINT "FK_LicencasERS_Ficheiros_FicheiroId" FOREIGN KEY ("FicheiroId") REFERENCES weges."Ficheiros" ("Id") ON DELETE SET NULL;

ALTER TABLE weges."Servicos" ADD CONSTRAINT "FK_Servicos_Tipologias_TipologiaId" FOREIGN KEY ("TipologiaId") REFERENCES weges."Tipologias" ("Id") ON DELETE SET NULL;

INSERT INTO weges."__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20250110234808_AdicionadaTipologia', '8.0.12');

COMMIT;

START TRANSACTION;

ALTER TABLE weges."Ficheiros" ALTER COLUMN "Tipo" TYPE character varying(100);

ALTER TABLE weges."Ficheiros" ALTER COLUMN "Nome" TYPE character varying(255);

ALTER TABLE weges."Ficheiros" ALTER COLUMN "Localizacao" TYPE character varying(512);

ALTER TABLE weges."Estabelecimentos" ALTER COLUMN "TipoPrestador" TYPE character varying(100);

ALTER TABLE weges."Estabelecimentos" ALTER COLUMN "Telefone" TYPE character varying(50);

ALTER TABLE weges."Estabelecimentos" ALTER COLUMN "Sigla" TYPE character varying(50);

ALTER TABLE weges."Estabelecimentos" ALTER COLUMN "Morada" TYPE character varying(512);

ALTER TABLE weges."Estabelecimentos" ALTER COLUMN "Email" TYPE character varying(255);

ALTER TABLE weges."Estabelecimentos" ALTER COLUMN "Denominacao" TYPE character varying(255);

CREATE TABLE weges."AnexoTipos" (
    "Id" bigint GENERATED BY DEFAULT AS IDENTITY,
    "Tipo" character varying(100) NOT NULL,
    "Created" timestamp with time zone NOT NULL DEFAULT (NOW()),
    "CreatedBy" text DEFAULT 'system-usr',
    "Modified" timestamp with time zone NOT NULL DEFAULT (NOW()),
    "ModifiedBy" text DEFAULT 'system-usr',
    CONSTRAINT "PK_AnexoTipos" PRIMARY KEY ("Id")
);

CREATE TABLE weges."ColaboradorTipo" (
    "Id" bigint GENERATED BY DEFAULT AS IDENTITY,
    "Tipo" text NOT NULL,
    "Created" timestamp with time zone NOT NULL DEFAULT (NOW()),
    "CreatedBy" text DEFAULT 'system-usr',
    "Modified" timestamp with time zone NOT NULL DEFAULT (NOW()),
    "ModifiedBy" text DEFAULT 'system-usr',
    CONSTRAINT "PK_ColaboradorTipo" PRIMARY KEY ("Id")
);

CREATE TABLE weges."Anexos" (
    "Id" bigint GENERATED BY DEFAULT AS IDENTITY,
    "Nome" character varying(255) NOT NULL,
    "Submetido" date NOT NULL,
    "Observacoes" character varying(1000),
    "FicheiroId" bigint NOT NULL,
    "AnexoTipoId" bigint NOT NULL,
    "Created" timestamp with time zone NOT NULL,
    "CreatedBy" text,
    "Modified" timestamp with time zone NOT NULL,
    "ModifiedBy" text,
    CONSTRAINT "PK_Anexos" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_Anexos_AnexoTipos_AnexoTipoId" FOREIGN KEY ("AnexoTipoId") REFERENCES weges."AnexoTipos" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_Anexos_Ficheiros_FicheiroId" FOREIGN KEY ("FicheiroId") REFERENCES weges."Ficheiros" ("Id") ON DELETE CASCADE
);

CREATE TABLE weges."Colaborador" (
    "Id" bigint GENERATED BY DEFAULT AS IDENTITY,
    "Nome" text NOT NULL,
    "NrIdentificacao" text NOT NULL,
    "DataNascimento" date NOT NULL,
    "InicioAtividade" date NOT NULL,
    "Cedula" text NOT NULL,
    "Especialidade" text NOT NULL,
    "Estado" boolean NOT NULL,
    "TotalHoras" integer NOT NULL,
    "Observacoes" text NOT NULL,
    "ServicoId" bigint NOT NULL,
    "EstabelecimentoId" bigint NOT NULL,
    "ColaboradorTipoId" bigint NOT NULL,
    "Created" timestamp with time zone NOT NULL DEFAULT (NOW()),
    "CreatedBy" text DEFAULT 'system-usr',
    "Modified" timestamp with time zone NOT NULL DEFAULT (NOW()),
    "ModifiedBy" text DEFAULT 'system-usr',
    CONSTRAINT "PK_Colaborador" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_Colaborador_ColaboradorTipo_ColaboradorTipoId" FOREIGN KEY ("ColaboradorTipoId") REFERENCES weges."ColaboradorTipo" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_Colaborador_Estabelecimentos_EstabelecimentoId" FOREIGN KEY ("EstabelecimentoId") REFERENCES weges."Estabelecimentos" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_Colaborador_Servicos_ServicoId" FOREIGN KEY ("ServicoId") REFERENCES weges."Servicos" ("Id") ON DELETE CASCADE
);

CREATE TABLE weges."EstabelecimentoAnexos" (
    "EstabelecimentoId" bigint NOT NULL,
    "AnexoId" bigint NOT NULL,
    CONSTRAINT "PK_EstabelecimentoAnexos" PRIMARY KEY ("EstabelecimentoId", "AnexoId"),
    CONSTRAINT "FK_EstabelecimentoAnexos_Anexos_AnexoId" FOREIGN KEY ("AnexoId") REFERENCES weges."Anexos" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_EstabelecimentoAnexos_Estabelecimentos_EstabelecimentoId" FOREIGN KEY ("EstabelecimentoId") REFERENCES weges."Estabelecimentos" ("Id") ON DELETE CASCADE
);

CREATE TABLE weges."Formacao" (
    "Id" bigint GENERATED BY DEFAULT AS IDENTITY,
    "Nome" text NOT NULL,
    "HorasFormacao" integer NOT NULL,
    "Data" date NOT NULL,
    "Observacoes" text,
    "ColaboradorId" bigint,
    "Created" timestamp with time zone NOT NULL DEFAULT (NOW()),
    "CreatedBy" text DEFAULT 'system-usr',
    "Modified" timestamp with time zone NOT NULL DEFAULT (NOW()),
    "ModifiedBy" text DEFAULT 'system-usr',
    CONSTRAINT "PK_Formacao" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_Formacao_Colaborador_ColaboradorId" FOREIGN KEY ("ColaboradorId") REFERENCES weges."Colaborador" ("Id")
);

CREATE INDEX "IX_Anexos_AnexoTipoId" ON weges."Anexos" ("AnexoTipoId");

CREATE INDEX "IX_Anexos_FicheiroId" ON weges."Anexos" ("FicheiroId");

CREATE INDEX "IX_Colaborador_ColaboradorTipoId" ON weges."Colaborador" ("ColaboradorTipoId");

CREATE INDEX "IX_Colaborador_EstabelecimentoId" ON weges."Colaborador" ("EstabelecimentoId");

CREATE INDEX "IX_Colaborador_ServicoId" ON weges."Colaborador" ("ServicoId");

CREATE INDEX "IX_EstabelecimentoAnexos_AnexoId" ON weges."EstabelecimentoAnexos" ("AnexoId");

CREATE INDEX "IX_Formacao_ColaboradorId" ON weges."Formacao" ("ColaboradorId");

INSERT INTO weges."__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20250121213532_CartoesNipc', '8.0.12');

COMMIT;

START TRANSACTION;

DROP TABLE weges."EstabelecimentoAnexos";

CREATE TABLE weges."EstabelecimentoAlvaras" (
    "EstabelecimentoId" bigint NOT NULL,
    "AnexoId" bigint NOT NULL,
    CONSTRAINT "PK_EstabelecimentoAlvaras" PRIMARY KEY ("EstabelecimentoId", "AnexoId"),
    CONSTRAINT "FK_EstabelecimentoAlvaras_Anexos_AnexoId" FOREIGN KEY ("AnexoId") REFERENCES weges."Anexos" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_EstabelecimentoAlvaras_Estabelecimentos_EstabelecimentoId" FOREIGN KEY ("EstabelecimentoId") REFERENCES weges."Estabelecimentos" ("Id") ON DELETE CASCADE
);

CREATE TABLE weges."EstabelecimentoCartoesNipc" (
    "EstabelecimentoId" bigint NOT NULL,
    "AnexoId" bigint NOT NULL,
    CONSTRAINT "PK_EstabelecimentoCartoesNipc" PRIMARY KEY ("EstabelecimentoId", "AnexoId"),
    CONSTRAINT "FK_EstabelecimentoCartoesNipc_Anexos_AnexoId" FOREIGN KEY ("AnexoId") REFERENCES weges."Anexos" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_EstabelecimentoCartoesNipc_Estabelecimentos_Estabelecimento~" FOREIGN KEY ("EstabelecimentoId") REFERENCES weges."Estabelecimentos" ("Id") ON DELETE CASCADE
);

CREATE TABLE weges."EstabelecimentoMedidasANPC" (
    "EstabelecimentoId" bigint NOT NULL,
    "AnexoId" bigint NOT NULL,
    CONSTRAINT "PK_EstabelecimentoMedidasANPC" PRIMARY KEY ("EstabelecimentoId", "AnexoId"),
    CONSTRAINT "FK_EstabelecimentoMedidasANPC_Anexos_AnexoId" FOREIGN KEY ("AnexoId") REFERENCES weges."Anexos" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_EstabelecimentoMedidasANPC_Estabelecimentos_Estabelecimento~" FOREIGN KEY ("EstabelecimentoId") REFERENCES weges."Estabelecimentos" ("Id") ON DELETE CASCADE
);

CREATE TABLE weges."EstabelecimentoParecerANPC" (
    "EstabelecimentoId" bigint NOT NULL,
    "AnexoId" bigint NOT NULL,
    CONSTRAINT "PK_EstabelecimentoParecerANPC" PRIMARY KEY ("EstabelecimentoId", "AnexoId"),
    CONSTRAINT "FK_EstabelecimentoParecerANPC_Anexos_AnexoId" FOREIGN KEY ("AnexoId") REFERENCES weges."Anexos" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_EstabelecimentoParecerANPC_Estabelecimentos_Estabelecimento~" FOREIGN KEY ("EstabelecimentoId") REFERENCES weges."Estabelecimentos" ("Id") ON DELETE CASCADE
);

CREATE INDEX "IX_EstabelecimentoAlvaras_AnexoId" ON weges."EstabelecimentoAlvaras" ("AnexoId");

CREATE INDEX "IX_EstabelecimentoCartoesNipc_AnexoId" ON weges."EstabelecimentoCartoesNipc" ("AnexoId");

CREATE INDEX "IX_EstabelecimentoMedidasANPC_AnexoId" ON weges."EstabelecimentoMedidasANPC" ("AnexoId");

CREATE INDEX "IX_EstabelecimentoParecerANPC_AnexoId" ON weges."EstabelecimentoParecerANPC" ("AnexoId");

INSERT INTO weges."__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20250121215026_AlvarasMedidasANPCParecerANPC', '8.0.12');

COMMIT;

START TRANSACTION;

CREATE TABLE weges."EstabelecimentoDireitosDeveres" (
    "EstabelecimentoId" bigint NOT NULL,
    "AnexoId" bigint NOT NULL,
    CONSTRAINT "PK_EstabelecimentoDireitosDeveres" PRIMARY KEY ("EstabelecimentoId", "AnexoId"),
    CONSTRAINT "FK_EstabelecimentoDireitosDeveres_Anexos_AnexoId" FOREIGN KEY ("AnexoId") REFERENCES weges."Anexos" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_EstabelecimentoDireitosDeveres_Estabelecimentos_Estabelecim~" FOREIGN KEY ("EstabelecimentoId") REFERENCES weges."Estabelecimentos" ("Id") ON DELETE CASCADE
);

CREATE TABLE weges."EstabelecimentoFicheirosAnexar" (
    "EstabelecimentoId" bigint NOT NULL,
    "AnexoId" bigint NOT NULL,
    CONSTRAINT "PK_EstabelecimentoFicheirosAnexar" PRIMARY KEY ("EstabelecimentoId", "AnexoId"),
    CONSTRAINT "FK_EstabelecimentoFicheirosAnexar_Anexos_AnexoId" FOREIGN KEY ("AnexoId") REFERENCES weges."Anexos" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_EstabelecimentoFicheirosAnexar_Estabelecimentos_Estabelecim~" FOREIGN KEY ("EstabelecimentoId") REFERENCES weges."Estabelecimentos" ("Id") ON DELETE CASCADE
);

CREATE TABLE weges."EstabelecimentoLicenciamentoRegistoLegal" (
    "EstabelecimentoId" bigint NOT NULL,
    "AnexoId" bigint NOT NULL,
    CONSTRAINT "PK_EstabelecimentoLicenciamentoRegistoLegal" PRIMARY KEY ("EstabelecimentoId", "AnexoId"),
    CONSTRAINT "FK_EstabelecimentoLicenciamentoRegistoLegal_Anexos_AnexoId" FOREIGN KEY ("AnexoId") REFERENCES weges."Anexos" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_EstabelecimentoLicenciamentoRegistoLegal_Estabelecimentos_E~" FOREIGN KEY ("EstabelecimentoId") REFERENCES weges."Estabelecimentos" ("Id") ON DELETE CASCADE
);

CREATE TABLE weges."EstabelecimentoListaVerificacao" (
    "EstabelecimentoId" bigint NOT NULL,
    "AnexoId" bigint NOT NULL,
    CONSTRAINT "PK_EstabelecimentoListaVerificacao" PRIMARY KEY ("EstabelecimentoId", "AnexoId"),
    CONSTRAINT "FK_EstabelecimentoListaVerificacao_Anexos_AnexoId" FOREIGN KEY ("AnexoId") REFERENCES weges."Anexos" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_EstabelecimentoListaVerificacao_Estabelecimentos_Estabeleci~" FOREIGN KEY ("EstabelecimentoId") REFERENCES weges."Estabelecimentos" ("Id") ON DELETE CASCADE
);

CREATE INDEX "IX_EstabelecimentoDireitosDeveres_AnexoId" ON weges."EstabelecimentoDireitosDeveres" ("AnexoId");

CREATE INDEX "IX_EstabelecimentoFicheirosAnexar_AnexoId" ON weges."EstabelecimentoFicheirosAnexar" ("AnexoId");

CREATE INDEX "IX_EstabelecimentoLicenciamentoRegistoLegal_AnexoId" ON weges."EstabelecimentoLicenciamentoRegistoLegal" ("AnexoId");

CREATE INDEX "IX_EstabelecimentoListaVerificacao_AnexoId" ON weges."EstabelecimentoListaVerificacao" ("AnexoId");

INSERT INTO weges."__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20250121221244_RestOfAnexosList', '8.0.12');

COMMIT;

START TRANSACTION;

ALTER TABLE weges."Colaborador" DROP CONSTRAINT "FK_Colaborador_ColaboradorTipo_ColaboradorTipoId";

ALTER TABLE weges."Colaborador" DROP CONSTRAINT "FK_Colaborador_Estabelecimentos_EstabelecimentoId";

ALTER TABLE weges."Colaborador" DROP CONSTRAINT "FK_Colaborador_Servicos_ServicoId";

ALTER TABLE weges."Formacao" DROP CONSTRAINT "FK_Formacao_Colaborador_ColaboradorId";

ALTER TABLE weges."Colaborador" DROP CONSTRAINT "PK_Colaborador";

ALTER TABLE weges."Colaborador" RENAME TO "Colaboradores";

ALTER INDEX weges."IX_Colaborador_ServicoId" RENAME TO "IX_Colaboradores_ServicoId";

ALTER INDEX weges."IX_Colaborador_EstabelecimentoId" RENAME TO "IX_Colaboradores_EstabelecimentoId";

ALTER INDEX weges."IX_Colaborador_ColaboradorTipoId" RENAME TO "IX_Colaboradores_ColaboradorTipoId";

ALTER TABLE weges."Colaboradores" ADD CONSTRAINT "PK_Colaboradores" PRIMARY KEY ("Id");

ALTER TABLE weges."Colaboradores" ADD CONSTRAINT "FK_Colaboradores_ColaboradorTipo_ColaboradorTipoId" FOREIGN KEY ("ColaboradorTipoId") REFERENCES weges."ColaboradorTipo" ("Id") ON DELETE SET NULL;

ALTER TABLE weges."Colaboradores" ADD CONSTRAINT "FK_Colaboradores_Estabelecimentos_EstabelecimentoId" FOREIGN KEY ("EstabelecimentoId") REFERENCES weges."Estabelecimentos" ("Id") ON DELETE SET NULL;

ALTER TABLE weges."Colaboradores" ADD CONSTRAINT "FK_Colaboradores_Servicos_ServicoId" FOREIGN KEY ("ServicoId") REFERENCES weges."Servicos" ("Id") ON DELETE CASCADE;

ALTER TABLE weges."Formacao" ADD CONSTRAINT "FK_Formacao_Colaboradores_ColaboradorId" FOREIGN KEY ("ColaboradorId") REFERENCES weges."Colaboradores" ("Id");

INSERT INTO weges."__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20250121224038_Colaborador', '8.0.12');

COMMIT;


