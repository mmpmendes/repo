﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;
using weges_v2.ApiModel;

#nullable disable

namespace weges_v2.DbMigrations.Migrations
{
    [DbContext(typeof(WegesDbContext))]
    [Migration("20250101233140_AddedServicos")]
    partial class AddedServicos
    {
        /// <inheritdoc />
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasDefaultSchema("weges")
                .HasAnnotation("ProductVersion", "8.0.11")
                .HasAnnotation("Relational:MaxIdentifierLength", 63);

            NpgsqlModelBuilderExtensions.UseIdentityByDefaultColumns(modelBuilder);

            modelBuilder.Entity("CodCaeEntidade", b =>
                {
                    b.Property<long>("CodCaesId")
                        .HasColumnType("bigint");

                    b.Property<long>("EntidadesId")
                        .HasColumnType("bigint");

                    b.HasKey("CodCaesId", "EntidadesId");

                    b.HasIndex("EntidadesId");

                    b.ToTable("CodCaeEntidade", "weges");
                });

            modelBuilder.Entity("weges_v2.ApiModel.Models.CodCae", b =>
                {
                    b.Property<long>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("bigint");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<long>("Id"));

                    b.Property<string>("Codigo")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<DateTime>("Created")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("CreatedBy")
                        .HasColumnType("text");

                    b.Property<string>("Designacao")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<DateTime>("Modified")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("ModifiedBy")
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.ToTable("CodCaes", "weges");
                });

            modelBuilder.Entity("weges_v2.ApiModel.Models.DirecaoClinica", b =>
                {
                    b.Property<long>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("bigint");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<long>("Id"));

                    b.Property<string>("Cargo")
                        .HasColumnType("text");

                    b.Property<string>("Cedula")
                        .HasColumnType("text");

                    b.Property<DateTime>("Created")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("CreatedBy")
                        .HasColumnType("text");

                    b.Property<string>("Especialidade")
                        .HasColumnType("text");

                    b.Property<long>("EspecialidadeId")
                        .HasColumnType("bigint");

                    b.Property<long>("EstabelecimentoId")
                        .HasColumnType("bigint");

                    b.Property<string>("Identificacao")
                        .HasColumnType("text");

                    b.Property<DateTime>("Modified")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("ModifiedBy")
                        .HasColumnType("text");

                    b.Property<string>("Nome")
                        .HasColumnType("text");

                    b.Property<string>("Observacoes")
                        .HasColumnType("text");

                    b.Property<string>("Ordem")
                        .HasColumnType("text");

                    b.Property<string>("Tipologia")
                        .HasColumnType("text");

                    b.Property<long>("TipologiaId")
                        .HasColumnType("bigint");

                    b.Property<DateOnly>("ValidadeIdentificacao")
                        .HasColumnType("date");

                    b.HasKey("Id");

                    b.ToTable("DirecoesClinicas", "weges");

                    b.HasData(
                        new
                        {
                            Id = 1L,
                            Cargo = "Cargo 1",
                            Cedula = "Cedula 1",
                            Created = new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified),
                            Especialidade = "Especialidade 1",
                            EspecialidadeId = 1L,
                            EstabelecimentoId = 1L,
                            Identificacao = "Identificacao 1",
                            Modified = new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified),
                            Nome = "Nome 1",
                            Observacoes = "Observacoes 1",
                            Ordem = "Ordem 1",
                            Tipologia = "Tipologia 1",
                            TipologiaId = 1L,
                            ValidadeIdentificacao = new DateOnly(2023, 2, 20)
                        },
                        new
                        {
                            Id = 2L,
                            Cargo = "Cargo 2",
                            Cedula = "Cedula 2",
                            Created = new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified),
                            Especialidade = "Especialidade 2",
                            EspecialidadeId = 2L,
                            EstabelecimentoId = 2L,
                            Identificacao = "Identificacao 2",
                            Modified = new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified),
                            Nome = "Nome 2",
                            Observacoes = "Observacoes 2",
                            Ordem = "Ordem 2",
                            Tipologia = "Tipologia 2",
                            TipologiaId = 2L,
                            ValidadeIdentificacao = new DateOnly(2023, 2, 20)
                        });
                });

            modelBuilder.Entity("weges_v2.ApiModel.Models.Entidade", b =>
                {
                    b.Property<long>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("bigint");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<long>("Id"));

                    b.Property<DateTime>("Created")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("timestamp with time zone")
                        .HasDefaultValueSql("NOW()");

                    b.Property<string>("CreatedBy")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("text")
                        .HasDefaultValue("system-usr");

                    b.Property<string>("Denominacao")
                        .HasMaxLength(200)
                        .HasColumnType("character varying(200)");

                    b.Property<string>("Email")
                        .HasMaxLength(50)
                        .HasColumnType("character varying(50)");

                    b.Property<string>("EmailNotificacoesERS")
                        .HasMaxLength(50)
                        .HasColumnType("character varying(50)");

                    b.Property<string>("EmailNotificacoesGerais")
                        .HasMaxLength(50)
                        .HasColumnType("character varying(50)");

                    b.Property<DateTime>("Modified")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("timestamp with time zone")
                        .HasDefaultValueSql("NOW()");

                    b.Property<string>("ModifiedBy")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("text")
                        .HasDefaultValue("system-usr");

                    b.Property<string>("Morada")
                        .HasMaxLength(200)
                        .HasColumnType("character varying(200)");

                    b.Property<string>("NifNipc")
                        .IsRequired()
                        .HasMaxLength(9)
                        .HasColumnType("character varying(9)");

                    b.Property<string>("NrERS")
                        .HasColumnType("text");

                    b.Property<string>("Sigla")
                        .HasMaxLength(8)
                        .HasColumnType("character varying(8)");

                    b.Property<string>("Telefone")
                        .HasMaxLength(9)
                        .HasColumnType("character varying(9)");

                    b.HasKey("Id");

                    b.ToTable("Entidades", "weges");

                    b.HasData(
                        new
                        {
                            Id = 1L,
                            Created = new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified),
                            Denominacao = "Entidade 1",
                            Email = "emailteste@email.email",
                            EmailNotificacoesERS = "emailnotificacoes@email.email",
                            EmailNotificacoesGerais = "emailnotificacoes@email.email",
                            Modified = new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified),
                            Morada = "Rua do Teste 1",
                            NifNipc = "123123123",
                            NrERS = "A-1234",
                            Sigla = "ent1",
                            Telefone = "921111111"
                        },
                        new
                        {
                            Id = 2L,
                            Created = new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified),
                            Denominacao = "Entidade 2",
                            Email = "emailteste@email.email",
                            EmailNotificacoesERS = "emailnotificacoes@email.email",
                            EmailNotificacoesGerais = "emailnotificacoes@email.email",
                            Modified = new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified),
                            Morada = "Rua do Teste 2",
                            NifNipc = "123123123",
                            NrERS = "A-1234",
                            Sigla = "ent2",
                            Telefone = "921111111"
                        });
                });

            modelBuilder.Entity("weges_v2.ApiModel.Models.Estabelecimento", b =>
                {
                    b.Property<long>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("bigint");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<long>("Id"));

                    b.Property<DateTime>("Created")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("CreatedBy")
                        .HasColumnType("text");

                    b.Property<string>("Denominacao")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("Email")
                        .HasColumnType("text");

                    b.Property<DateOnly>("InicioAtividade")
                        .HasColumnType("date");

                    b.Property<DateTime>("Modified")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("ModifiedBy")
                        .HasColumnType("text");

                    b.Property<string>("Morada")
                        .HasColumnType("text");

                    b.Property<string>("Sigla")
                        .HasColumnType("text");

                    b.Property<string>("Telefone")
                        .HasColumnType("text");

                    b.Property<string>("TipoPrestador")
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.ToTable("Estabelecimentos", "weges");

                    b.HasData(
                        new
                        {
                            Id = 1L,
                            Created = new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified),
                            Denominacao = "Estabelecimento 1",
                            Email = "email@email.email",
                            InicioAtividade = new DateOnly(2020, 2, 20),
                            Modified = new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified),
                            Morada = "estab 1 morada",
                            Sigla = "estab1",
                            Telefone = "291111111",
                            TipoPrestador = "Tipo de Prestador"
                        },
                        new
                        {
                            Id = 2L,
                            Created = new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified),
                            Denominacao = "Estabelecimento 2",
                            Email = "email@email.email",
                            InicioAtividade = new DateOnly(2023, 2, 20),
                            Modified = new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified),
                            Morada = "estab 2 morada",
                            Sigla = "estab2",
                            Telefone = "291111112",
                            TipoPrestador = "Tipo de Prestador"
                        });
                });

            modelBuilder.Entity("weges_v2.ApiModel.Models.Servico", b =>
                {
                    b.Property<long>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("bigint");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<long>("Id"));

                    b.Property<DateTime>("Created")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("CreatedBy")
                        .HasColumnType("text");

                    b.Property<DateOnly?>("DataInicio")
                        .HasColumnType("date");

                    b.Property<long>("EstabelecimentoId")
                        .HasColumnType("bigint");

                    b.Property<string>("Horario")
                        .HasColumnType("text");

                    b.Property<DateTime>("Modified")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("ModifiedBy")
                        .HasColumnType("text");

                    b.Property<string>("Nome")
                        .HasColumnType("text");

                    b.Property<string>("Observacoes")
                        .HasColumnType("text");

                    b.Property<string>("Responsavel")
                        .HasColumnType("text");

                    b.Property<string>("Tipologia")
                        .HasColumnType("text");

                    b.Property<long>("TipologiaId")
                        .HasColumnType("bigint");

                    b.HasKey("Id");

                    b.ToTable("Servicos", "weges");

                    b.HasData(
                        new
                        {
                            Id = 1L,
                            Created = new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified),
                            DataInicio = new DateOnly(2023, 2, 20),
                            EstabelecimentoId = 1L,
                            Horario = "Horario 1",
                            Modified = new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified),
                            Nome = "Servico 1",
                            Observacoes = "Observacoes 1",
                            Responsavel = "Responsavel 1",
                            Tipologia = "Tipologia 1",
                            TipologiaId = 1L
                        },
                        new
                        {
                            Id = 2L,
                            Created = new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified),
                            DataInicio = new DateOnly(2023, 2, 20),
                            EstabelecimentoId = 2L,
                            Horario = "Horario 2",
                            Modified = new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified),
                            Nome = "Servico 2",
                            Observacoes = "Observacoes 2",
                            Responsavel = "Responsavel 2",
                            Tipologia = "Tipologia 2",
                            TipologiaId = 2L
                        });
                });

            modelBuilder.Entity("CodCaeEntidade", b =>
                {
                    b.HasOne("weges_v2.ApiModel.Models.CodCae", null)
                        .WithMany()
                        .HasForeignKey("CodCaesId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("weges_v2.ApiModel.Models.Entidade", null)
                        .WithMany()
                        .HasForeignKey("EntidadesId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });
#pragma warning restore 612, 618
        }
    }
}
