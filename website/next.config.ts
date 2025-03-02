import nextra from "nextra";

const withNextra = nextra({
  search: {
    codeblocks: false
  },
  readingTime: false,
  contentDirBasePath: "/docs",
});

export default withNextra({});
