import { Inter } from 'next/font/google';
import './globals.css';
import { UserProvider } from '@/context/UserContext';

const inter = Inter({ subsets: ['latin'] });

export const metadata = {
  title: 'VitalityAI - Health & Fitness',
  description: 'Integrated Health & Fitness Web Application with 3D Body Visualization',
};

export default function RootLayout({ children }) {
  return (
    <html lang="ar" dir="rtl" suppressHydrationWarning>
      <body className={inter.className} suppressHydrationWarning>
        <UserProvider>
          {children}
        </UserProvider>
      </body>
    </html>
  );
}
