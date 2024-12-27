var builder = DistributedApplication.CreateBuilder(args);

//var cache = builder.AddRedis("cache")//.WithLifetime(ContainerLifetime.Persistent)
//    .WithContainerName("weges-cache");

var postgres = builder.AddPostgres("postgres-server")
                      .WithContainerName("weges-postgres-container").WithPgAdmin();//.WithLifetime(ContainerLifetime.Persistent);

var db = postgres.AddDatabase("weges");

var migrationService = builder.AddProject<Projects.weges_v2_DbMigrations>("weges-migration")
    .WithReference(db)
    .WaitFor(db);

var usersMigrationService = builder.AddProject<Projects.weges_v2_UsersMigrations>("users-migration")
    .WithReference(db)
    .WaitFor(db);

var apiService = builder.AddProject<Projects.weges_v2_ApiService>("apiservice")
                    .WithReference(db);
//.WaitForCompletion(migrationService);

builder.AddProject<Projects.weges_v2_Web>("webfrontend")
    .WithExternalHttpEndpoints()
    //.WithReference(cache)
    //.WaitFor(cache)
    .WithReference(apiService)
    .WaitFor(apiService);

builder.Build().Run();
