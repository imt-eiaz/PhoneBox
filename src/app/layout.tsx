import Provider from "@/layouts/Provider";

export const metadata = {
  title: {
    default: "PhoneBox",
    template: "%s - PhoneBox",
  },
};

export default function RootLayout({ children }: React.PropsWithChildren) {
  return (
    <html lang="en">
      <body>
        <Provider>{children}</Provider>
      </body>
    </html>
  );
}
