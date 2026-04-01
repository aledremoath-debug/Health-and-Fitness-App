'use client';

import React from 'react';
import Link from 'next/link';
import dynamic from 'next/dynamic';
import { useUser } from '@/context/UserContext';
import Navbar from '@/components/Navbar';
import { ChevronLeft, Download, Heart, BarChart3 } from 'lucide-react';

// Isolated Dynamic Imports
const BarChartComponent = dynamic(() => import('@/components/BarChartComponent'), {
    ssr: false,
    loading: () => <div className="w-full h-full flex items-center justify-center text-dim">Loading Statistics...</div>
});

const PieChartComponent = dynamic(() => import('@/components/PieChartComponent'), {
    ssr: false,
    loading: () => <div className="w-full h-full flex items-center justify-center text-dim">Loading Statistics...</div>
});

export default function Reports() {
    const { t, userData } = useUser();

    const data = [
        { name: 'Sat', value: 2100 },
        { name: 'Sun', value: 1900 },
        { name: 'Mon', value: 2200 },
        { name: 'Tue', value: 2000 },
        { name: 'Wed', value: 1800 },
        { name: 'Thu', value: 2400 },
        { name: 'Fri', value: 1700 },
    ];

    const macroData = [
        { name: t.protein, value: 30, color: '#10b981' },
        { name: t.carbs, value: 45, color: '#3b82f6' },
        { name: t.fats, value: 25, color: '#f59e0b' },
    ];

    return (
        <main className="min-h-screen">
            <Navbar />

            <div className="pt-32 pb-24 px-4 md:px-12 max-w-[1400px] mx-auto space-y-12" suppressHydrationWarning>
                <div className="flex flex-col md:flex-row justify-between items-start md:items-center gap-6">
                    <div>
                        <h1 className="text-5xl font-black mb-3 tracking-tighter">{t.reports}</h1>
                        <p className="text-dim text-sm font-medium">Deep dive into your nutritional and performance data.</p>
                    </div>
                    <button className="flex items-center gap-3 bg-blue-600 hover:bg-blue-500 text-white px-8 py-4 rounded-[2rem] font-black uppercase tracking-widest text-xs transition-all shadow-xl shadow-blue-500/30 active:scale-95">
                        <Download size={18} /> {t.downloadReport}
                    </button>
                </div>

                <div className="grid grid-cols-1 lg:grid-cols-3 gap-10">
                    {/* Main Chart */}
                    <div className="lg:col-span-2 theme-card p-10 min-h-[500px]">
                        <div className="flex items-center justify-between mb-10">
                            <h3 className="font-black text-xl tracking-tight">{t.calorieTrend}</h3>
                            <div className="text-[10px] font-black uppercase tracking-widest text-dim">Weekly Overview</div>
                        </div>
                        <div className="h-[350px] w-full">
                            <BarChartComponent data={data} />
                        </div>
                    </div>

                    {/* Pie Chart */}
                    <div className="theme-card p-10 flex flex-col items-center min-h-[500px]">
                        <div className="w-full flex items-center justify-between mb-10">
                            <h3 className="font-black text-xl tracking-tight">{t.results} {t.macros}</h3>
                            <div className="p-2 bg-blue-500/10 rounded-xl">
                                <BarChart3 size={18} className="text-blue-500" />
                            </div>
                        </div>
                        <div className="h-[250px] w-full mb-10">
                            <PieChartComponent data={macroData} />
                        </div>
                        <div className="space-y-5 w-full">
                            {macroData.map((item) => (
                                <div key={item.name} className="flex justify-between items-center bg-white/5 p-4 rounded-2xl border border-white/5">
                                    <div className="flex items-center gap-4">
                                        <div className="w-3 h-3 rounded-full shadow-[0_0_8px_rgba(var(--primary),0.5)]" style={{ backgroundColor: item.color }} />
                                        <span className="text-dim text-xs font-black uppercase tracking-widest">{item.name}</span>
                                    </div>
                                    <span className="font-black text-main">{item.value}%</span>
                                </div>
                            ))}
                        </div>
                    </div>
                </div>
            </div>
        </main>
    );
}
