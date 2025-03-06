import { Layout, Navbar } from "nextra-theme-docs";
import { Head } from "nextra/components";
import { getPageMap } from "nextra/page-map";
import "nextra-theme-docs/style.css";

export const metadata = {};

const navbar = (
  <Navbar
    logo={
      <svg
        width="31"
        height="30"
        viewBox="0 0 31 30"
        fill="none"
        xmlns="http://www.w3.org/2000/svg"
      >
        <path
          fillRule="evenodd"
          clipRule="evenodd"
          d="M8.78906 30H0L9.90234 0H21.0352L30.9375 30H22.1484L20.4149 24.2578H29.0421L27.0307 18.1641H18.5753L15.5859 8.26172H15.3516L12.3622 18.1641H3.90678L1.89537 24.2578H10.5226L8.78906 30ZM10.5226 24.2578L12.3622 18.1641H18.5753L20.4149 24.2578H10.5226Z"
          fill="currentColor"
        />
      </svg>
    }
    projectLink="https://github.com/francids/anaquel"
  />
);
const footer = <></>;

const RootLayout = async ({ children }) => {
  return (
    <html lang="es" dir="ltr" suppressHydrationWarning>
      <Head
        color={{
          hue: 348,
          saturation: 71,
          lightness: {
            light: 34,
            dark: 34,
          },
        }}
      />
      <body>
        <Layout
          navbar={navbar}
          pageMap={await getPageMap()}
          docsRepositoryBase="https://github.com/francids/anaquel/tree/master/website"
          footer={footer}
          editLink={null}
          feedback={{
            content: null,
          }}
        >
          {children}
        </Layout>
      </body>
    </html>
  );
};

export default RootLayout;
