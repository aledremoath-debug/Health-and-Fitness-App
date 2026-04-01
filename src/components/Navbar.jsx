'use client';

import React, { useState } from 'react';
import Link from 'next/link';
import { usePathname } from 'next/navigation';
import { useUser } from '@/context/UserContext';
import { Heart, LayoutDashboard, BarChart3, Settings, Menu, X } from 'lucide-react';

const Navbar = () => {
    const { userData, t } = useUser();
    const pathname = usePathname();
    const [isMenuOpen, setIsMenuOpen] = useState(false);

    const navLinks = [
        { href: '/', label: t.dashboard, icon: <LayoutDashboard size={18} /> },
        { href: '/reports', label: t.reports, icon: <BarChart3 size={18} /> },
        { href: '/settings', label: t.settings, icon: <Settings size={18} /> },
    ];

    return (
        <nav className="fixed top-0 w-full z-50 bg-[rgba(var(--background),0.7)] backdrop-blur-2xl border-b border-[rgba(var(--surface-border))] py-3 px-6 md:px-12 flex justify-between items-center transition-all">
            {/* Logo */}
            <div className="flex items-center gap-4">
                <div className="w-11 h-11 bg-gradient-to-tr from-blue-600 to-indigo-600 rounded-2xl flex items-center justify-center shadow-lg shadow-blue-500/30">
                    <Heart className="text-white" size={22} fill="currentColor" />
                </div>
                <span className="text-2xl font-black bg-clip-text text-transparent bg-gradient-to-r from-[rgb(var(--primary))] to-[rgb(var(--accent))] tracking-tight">
                    {t.appName}
                </span>
            </div>

            {/* Desktop Links */}
            <div className="hidden md:flex gap-1 bg-white/5 p-1 rounded-2xl border border-white/5">
                {navLinks.map((link) => {
                    const isActive = pathname === link.href;
                    return (
                        <Link
                            key={link.href}
                            href={link.href}
                            className={`px-6 py-2 rounded-xl flex items-center gap-2 font-bold transition-all ${isActive
                                ? "bg-blue-600 text-white shadow-lg shadow-blue-500/20"
                                : "text-dim hover:text-main hover:bg-white/5"
                                }`}
                        >
                            {link.icon} {link.label}
                        </Link>
                    );
                })}
            </div>

            {/* Right side: Profile & Mobile Toggle */}
            <div className="flex items-center gap-4">
                <div className="hidden sm:flex flex-col items-end ltr:items-start mr-3 ml-3 text-right">
                    <span className="text-sm font-black text-main">{userData.name}</span>
                    <span className="text-[10px] uppercase font-bold text-blue-500 tracking-widest">Premium Member</span>
                </div>
                <Link href="/settings" className="w-12 h-12 rounded-2xl bg-white/5 border border-white/5 flex items-center justify-center hover:bg-white/10 transition-all group overflow-hidden">
                    <img src={`https://api.dicebear.com/7.x/avataaars/svg?seed=${userData.name}`} className="w-full h-full object-cover p-1" alt="" />
                </Link>

                {/* Mobile Menu Toggle */}
                <button
                    onClick={() => setIsMenuOpen(!isMenuOpen)}
                    className="md:hidden w-12 h-12 rounded-2xl bg-white/5 border border-white/5 flex items-center justify-center hover:bg-white/10 transition-all"
                >
                    {isMenuOpen ? <X size={24} /> : <Menu size={24} />}
                </button>
            </div>

            {/* Mobile Menu Overlay */}
            {isMenuOpen && (
                <div className="absolute top-full left-0 w-full bg-[rgb(var(--background))] border-b border-[rgba(var(--surface-border))] p-6 flex flex-col gap-4 md:hidden animate-in slide-in-from-top-4">
                    {navLinks.map((link) => (
                        <Link
                            key={link.href}
                            href={link.href}
                            onClick={() => setIsMenuOpen(false)}
                            className={`flex items-center gap-4 p-4 rounded-2xl font-bold ${pathname === link.href ? "bg-blue-600 text-white" : "bg-white/5 text-dim"}`}
                        >
                            {link.icon} {link.label}
                        </Link>
                    ))}
                </div>
            )}
        </nav>
    );
};

export default Navbar;
