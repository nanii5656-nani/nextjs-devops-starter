export default function Home() {
  return (
    <main
      style={{
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
        height: "100vh",
        fontFamily: "system-ui, sans-serif",
      }}
    >
      <div style={{ textAlign: "center" }}>
        <h1>DevOps Internship - Next.js App</h1>
        <p>This is a minimal Next.js app using the App Router.</p>
        <p>Health endpoint: <code>/api/health</code></p>
      </div>
    </main>
  );
}
