import express from "express";
import path from "path";
import http from "http";
import cors from "cors";
import bodyParser from "body-parser";
import { ApolloServer } from "@apollo/server";
import { expressMiddleware } from "@apollo/server/express4";
import { ApolloServerPluginDrainHttpServer } from "@apollo/server/plugin/drainHttpServer";
import { makeExecutableSchema } from "@graphql-tools/schema";
import { WebSocketServer } from "ws";
import { useServer } from "graphql-ws/lib/use/ws";

import { typeDefs } from "./types/typeDefs.ts";
import { Query } from "./resolvers/Query.ts";
import { Mutation } from "./resolvers/Mutation.ts";
import { Subscription } from "./resolvers/Subscription.ts";

const app = express();

const resolvers = { Query, Mutation, Subscription };
const schema = makeExecutableSchema({ typeDefs, resolvers });

const httpServer = http.createServer(app);

const wsServer = new WebSocketServer({
  server: httpServer,
  path: "/",
});

const serverCleanup = useServer({ schema }, wsServer);

const server = new ApolloServer({
  schema,
  plugins: [
    // Proper shutdown for the HTTP server.
    ApolloServerPluginDrainHttpServer({ httpServer }),

    // Proper shutdown for the WebSocket server.
    {
      async serverWillStart() {
        return {
          async drainServer() {
            await serverCleanup.dispose();
          },
        };
      },
    },
  ],
});
await server.start();

// if (process.env.NODE_ENV === "development") {
app.use(
  "/",
  cors<cors.CorsRequest>(),
  bodyParser.json(),
  expressMiddleware(server),
);
// }

// if (process.env.NODE_ENV === "production") {
//   const __dirname = path.resolve();
//   app.use(express.static(path.join(__dirname, "../frontend", "dist")));
//   app.get("/*", function (req, res) {
//     res.sendFile(path.join(__dirname, "../frontend", "dist", "index.html"));
//   });
// }

const port = process.env.PORT || 5000;
// Now that our HTTP server is fully set up, we can listen to it.
httpServer.listen(port, () => {
  console.log(`🚀 Server ready at http://localhost:${port}/`);
});
