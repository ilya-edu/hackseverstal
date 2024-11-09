const routes = [
  {
    path: "/",
    component: () => import("layouts/MainLayout.vue"),
    children: [
      { path: "", component: () => import("pages/IndexPage.vue") },
      { path: "/auth", component: () => import("pages/AuthPage.vue") },
      {
        path: "/exhauster/:id",
        component: () => import("pages/ExhausterPage.vue"),
      },
      {
        path: "/upload",
        name: "Download",
        component: () => import("pages/DownloadPage.vue"),
      },
      {
        path: "/trends/:id",
        component: () => import("pages/TrendsPage.vue"),
        name: "trends",
      },
    ],
  },

  // Always leave this as last one,
  // but you can also remove it
  {
    path: "/:catchAll(.*)*",
    component: () => import("pages/ErrorNotFound.vue"),
  },
];

export default routes;
