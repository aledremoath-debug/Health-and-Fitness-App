'use client';

import React from 'react';
import {
    AreaChart, Area, LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer
} from 'recharts';

export function WeightChart({ data }) {
    return (
        <ResponsiveContainer width="100%" height="100%" minWidth={0}>
            <AreaChart data={data}>
                <defs>
                    <linearGradient id="colorWeight" x1="0" y1="0" x2="0" y2="1">
                        <stop offset="5%" stopColor="#10b981" stopOpacity={0.3} />
                        <stop offset="95%" stopColor="#10b981" stopOpacity={0} />
                    </linearGradient>
                </defs>
                <CartesianGrid strokeDasharray="3 3" stroke="rgba(var(--text-dim), 0.1)" vertical={false} />
                <XAxis dataKey="day" stroke="rgb(var(--text-dim))" fontSize={12} tickLine={false} axisLine={false} />
                <YAxis hide />
                <Tooltip
                    contentStyle={{ backgroundColor: 'rgb(var(--surface))', borderRadius: '12px', border: '1px solid rgba(var(--surface-border))' }}
                    itemStyle={{ color: '#10b981' }}
                />
                <Area
                    type="monotone"
                    dataKey="weight"
                    stroke="#10b981"
                    strokeWidth={3}
                    fillOpacity={1}
                    fill="url(#colorWeight)"
                />
            </AreaChart>
        </ResponsiveContainer>
    );
}

export function CaloriesChart({ data }) {
    return (
        <ResponsiveContainer width="100%" height="100%" minWidth={0}>
            <LineChart data={data}>
                <CartesianGrid strokeDasharray="3 3" stroke="rgba(var(--text-dim), 0.1)" vertical={false} />
                <XAxis dataKey="day" stroke="rgb(var(--text-dim))" fontSize={12} tickLine={false} axisLine={false} />
                <YAxis hide />
                <Tooltip
                    contentStyle={{ backgroundColor: 'rgb(var(--surface))', borderRadius: '12px', border: '1px solid rgba(var(--surface-border))' }}
                    itemStyle={{ color: '#3b82f6' }}
                />
                <Line
                    type="monotone"
                    dataKey="calories"
                    stroke="#3b82f6"
                    strokeWidth={3}
                    dot={{ fill: '#3b82f6', strokeWidth: 2 }}
                />
            </LineChart>
        </ResponsiveContainer>
    );
}
