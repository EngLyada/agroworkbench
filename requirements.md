Build a mobile-first, progressive application (PWA) for agricultural intelligence serving Individual Farmers, Farmer Groups/Cooperatives, and Agronomists in East Africa. The app provides AI-driven crop advisory, yield prediction, market forecasting, credit scoring, and input marketplace integration.

1. USER ROLES & AUTHENTICATION
   Role-Based Access System

Individual Farmer: Basic profile (name, phone, GPS location, crops, acreage)
Farmer Group/Cooperative: Manages multiple farmer profiles with aggregated analytics
Agronomist/Field Agent: Professional dashboard with farmer management tools

Auth Requirements:

Phone number-based authentication (OTP)
Role selection during onboarding
Persistent session with secure token storage
Guest mode with limited features

2. CORE FEATURES & SCREENS
   2.1 Home Dashboard (All Users)
   Layout Components:
   ├── Weather Widget (current conditions + 3-day forecast)
   ├── Critical Alerts Banner (pest warnings, rainfall, price spikes)
   ├── Quick Action Cards (4-card grid):
   │ ├── 🌿 My Farm / Farm Overview
   │ ├── 📈 Market Prices
   │ ├── 🤖 AI Advisory
   │ └── 💰 Credit Score / Financing
   └── Bottom Navigation: Home | Services | Markets | Profile
   2.2 Individual Farmer Dashboard
   Header Summary (Single Row):

Total Savings: $XXX
Total Land: XX Acres

Quick Actions (2 Rows × 2 Cards):
Row 1: [Buy Inputs] [Get Services]
Row 2: [Markets] [Profile]
Activity Summary Cards:

Loan Outstanding: $XXX
Insurance Policies: X Active
Agroinputs Ordered: X Items

Performance Section:

Crop Performance Card (yield % vs target with progress bar)
Market Prices Widget (mini chart with trend arrow)
Credit Score Meter (colored gauge: Green/Yellow/Red)
Latest AI Advisory Feed (scrollable list)

Action Button: 📊 Compare Seasons
2.3 Farmer Group Dashboard
Header:

Group Name: [Buyeda Farmer Corp]
Summary Row: Total Members: XX | Total Savings: $XXX | Total Land: XXX Acres

Quick Actions (Same 4-card layout as individual)
Activity Summary:

Group Loan Status
Collective Insurance Coverage
Bulk Orders Placed

Group Analytics:

Aggregate Yield Chart (bar/line graph by member)
Total Production Timeline
Income Distribution Chart
Member Performance Table (sortable: Name | Acres | Yield | Credit Score)

Action Buttons: 📥 Export Report | ➕ Add Member
2.4 Agronomist Panel
Map View (Default Screen):

Interactive map with GPS pins for assigned farms/groups
Color-coded pins (Green: Good | Yellow: Attention | Red: Critical)
Tap pin → Quick farm summary popup

Summary Cards (Top Row):

Total Farmers: XX | Total Groups: X | Total Acres: XXX

Quick Actions (Same 4-card layout)
Activity Summary:

Pending Field Visits: X
AI Recommendations Reviewed: XX/XX
Reports Submitted This Week: X

Farmer List View (Alternative to map):

Searchable table with filters (crop type, yield status, credit score)
Each row: [Farmer Name] [Crop] [Last Visit] [Status] [Actions ⋮]

Field Visit Module:

Add notes with rich text editor
Upload photos (max 5 per visit)
Override AI recommendations with justification field
Mark tasks complete/pending

3. AI/ML SERVICES (Accessible via "Services" Tab)
   3.1 AI Crop Advisory Engine
   Inputs:

Soil type, crop type, farm location, current weather, growth stage

Outputs:

Weekly advisory feed (planting, fertilization, irrigation, pest management, harvest timing)
Real-time push notifications for critical actions

UI Components:

Timeline view of upcoming tasks
"Why this advice?" expandable explanations
Thumbs up/down feedback mechanism

3.2 Yield Prediction Module
Screen Layout:
├── Predicted Yield Gauge (circular progress: Current / Target)
├── Confidence Level: XX% (with info tooltip)
├── Comparison Bar Chart: [Your Farm | Regional Avg | Top 10%]
├── Input Update Section:
│ ├── Current Growth Stage Dropdown
│ ├── Fertilizer Applied (kg/acre)
│ └── Irrigation Method
├── Historical Yield Line Graph (past 3 seasons)
└── [Export PDF Report] Button
ML Model Inputs:

Historical weather data, soil health metrics, input usage, satellite imagery (NDVI)

3.3 Market Prices & Forecasting
Screen Tabs: Local | Regional | Export
Price Chart:

Interactive line/candlestick chart (past 6 months + 3-month forecast)
Zoom, pan, and hover tooltip with exact prices

AI Insights Panel (Bottom Card):
🤖 Best Time to Sell Maize:
"Prices predicted to rise 12% in 2 weeks. Consider holding."
[Set Price Alert] [View Full Analysis]
Favorite Crops: Star icon to save commodities for quick tracking
3.4 AI Credit Scoring
Credit Score Display:
┌─────────────────────────────┐
│ Credit Score: 720/1000 │
│ ████████████░░░░░░░ │
│ Rating: MEDIUM RISK │
└─────────────────────────────┘
Score Breakdown (Accordion):

Productivity (40%): Good ✓
Consistency (30%): Average ~
Input Usage (20%): Excellent ✓
Payment History (10%): Good ✓

Actions:

💰 Save for Input → Link to savings feature
📄 Apply for Financing → Partner lender integrations
📈 Improve Your Score → Tips modal

Credit Evolution Graph: 12-month trend line

4. CHATBOT (AI Smart Agronomist)
   Interface:

Fixed bottom-right bubble icon on all screens
Fullscreen modal on mobile, side panel on tablet/desktop

Capabilities:

Natural language Q&A (e.g., "What fertilizer for maize in rainy season?")
Multilingual support: English, Luganda, Swahili (language selector in chat header)
Context-aware (knows user's crops, location, current season)
Quick action buttons (e.g., "Get Pest Control Tips", "Check Market Prices")

Technical:

Real-time streaming responses
Fallback to human agronomist if confidence < 70%

5. TECHNICAL STACK & REQUIREMENTS

Backend Integration
javascript// API Endpoints Structure
const API_ENDPOINTS = {
auth: '/api/auth/login',
farmer: '/api/farmer/profile',
advisory: '/api/services/advisory',
yield: '/api/services/yield-prediction',
prices: '/api/markets/prices',
credit: '/api/credit/score',
chat: '/api/chat/message'
};
Data Models
typescriptinterface Farmer {
id: string;
name: string;
phone: string;
location: { lat: number; lng: number };
crops: Crop[];
acreage: number;
groupId?: string;
}

interface Advisory {
id: string;
farmerId: string;
crop: string;
stage: string;
recommendations: string[];
confidence: number;
createdAt: Date;
}

interface YieldPrediction {
farmerId: string;
crop: string;
predictedYield: number;
unit: 'tons/acre';
confidence: number;
factors: Factor[];
}
Features

Offline Mode: Cache last 7 days of data, sync on reconnect
Push Notifications: Web Push API for alerts
Multilingual: i18n with JSON language files
Responsive: Mobile-first (320px+), tablet (768px+), desktop (1024px+)

6. UI/UX GUIDELINES
   Design System

Colors:

Primary: #10B981 (Green - Agriculture)
Secondary: #3B82F6 (Blue - Trust)
Warning: #F59E0B (Orange)
Danger: #EF4444 (Red)
Success: #22C55E

Typography:

Headers: Inter/Poppins (Bold)
Body: Inter (Regular/Medium)
Sizes: Mobile (14-16px base) | Desktop (16-18px base)

Components:

Card shadows: shadow-sm on mobile, shadow-md on desktop
Border radius: rounded-lg (8px)
Buttons: Full width on mobile, auto on desktop
Icons: Lucide React library

Accessibility

WCAG 2.1 AA compliance
Color contrast ratio ≥ 4.5:1
Touch targets ≥ 44×44px
Keyboard navigation support
Screen reader labels

7. SAMPLE USER FLOWS
   Flow 1: New Farmer Onboarding

Landing → Select Role (Farmer)
Phone OTP verification
Profile setup (name, crops, location via GPS)
Quick tutorial (3 slides)
Dashboard with sample advisory

Flow 2: Check Yield Prediction

Home → AI Advisory Card
Yield Prediction Tab
View gauge + comparison chart
Update growth stage → Recalculate
Export PDF report

Flow 3: Agronomist Field Visit

Login → Map View
Tap farmer pin → Farm summary
Click "Start Visit"
Add notes + photos
Review/Override AI advisory
Submit report → Syncs to farmer dashboard

8. DELIVERABLES FOR BOLT AI

Fully functional React PWA with:

3 role-based dashboards
8+ core screens (Home, Farmer, Group, Agronomist, Services, Markets, Chat, Credit)
Mock AI services with realistic dummy data
Responsive design (mobile-first)
Offline capability with service workers

Sample Data:

50 mock farmers with varied profiles
5 farmer groups
3 agronomists
90 days of weather/price/advisory data

Interactive Charts:

Yield prediction gauges
Market price trend graphs
Credit score evolution lines
Group performance comparisons

AI Chatbot:

Mock NLP responses for 20+ common questions
Multilingual support (hardcoded translations for demo)

9. BOLT-SPECIFIC INSTRUCTIONS

Use React state management (useState, useReducer) - NO localStorage
All data hardcoded in constants file for demo purposes
Charts must render without external API calls (use static datasets)
Responsive breakpoints: Mobile (default) | Tablet (768px) | Desktop (1024px)
No authentication logic (role selection dropdown on home screen)
Focus on UX/UI polish with smooth transitions and loading states

10. SUCCESS CRITERIA
    ✅ All 3 user dashboards fully functional
    ✅ AI services display realistic predictions/recommendations
    ✅ Charts and graphs render correctly with mock data
    ✅ Chatbot responds to 10+ sample queries
    ✅ Responsive on mobile (375px), tablet (768px), desktop (1440px)
    ✅ No console errors, smooth animations
    ✅ Clean, modern UI matching agritech theme

Build this application with a focus on intuitive navigation, data visualization excellence, and a delightful user experience that empowers farmers through AI-driven insights.
