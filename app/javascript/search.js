console.log("Hello from search.js");

// import instantsearch from "instantsearch.js";
// import { searchBox, hits } from "instantsearch.js/es/widgets";
// import TypesenseInstantSearchAdapter from "typesense-instantsearch-adapter";

// const typesenseInstantsearchAdapter = new TypesenseInstantSearchAdapter({
//   server: {
//     apiKey: "xyz", // Be sure to use an API key that only allows search operations
//     nodes: [
//       {
//         host: "localhost",
//         path: "", // Optional. Example: If you have your typesense mounted in localhost:8108/typesense, path should be equal to '/typesense'
//         port: "8108",
//         protocol: "http",
//       },
//     ],
//     cacheSearchResultsForSeconds: 2 * 60, // Cache search results from server. Defaults to 2 minutes. Set to 0 to disable caching.
//   },
//   // The following parameters are directly passed to Typesense's search API endpoint.
//   //  So you can pass any parameters supported by the search endpoint below.
//   //  query_by is required.
//   additionalSearchParameters: {
//     query_by: "title,description",
//   },
// });
// const searchClient = typesenseInstantsearchAdapter.searchClient;

// const search = instantsearch({
//   searchClient,
//   indexName: "exercises",
// });

// search.addWidgets([
//   searchBox({
//     container: "#searchbox",
//   }),
//   hits({
//     container: "#hits",
//     templates: {
//       item: `
//         <div class="hit-name">
//           {{#helpers.highlight}}{ "attribute": "name" }{{/helpers.highlight}}
//         </div>
//       `,
//     },
//   }),
// ]);

// search.start();
