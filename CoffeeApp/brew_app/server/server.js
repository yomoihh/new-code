/**
 * Brew 咖啡 App — 管理后台服务 + Web 管理界面
 *
 * 前端 Flutter 不依赖此服务运行，此服务仅用于管理员修改 data/ 和 uploads/
 * Web 管理界面: http://localhost:3000/admin
 * API: /api/products | /api/banners | /api/coffee-cards | /api/upload
 */

const http = require('http');
const fs = require('fs');
const path = require('path');
const crypto = require('crypto');

const PORT = 3000;
const ROOT = path.join(__dirname, '..');
const DATA_DIR = path.join(ROOT, 'data');
const UPLOADS_DIR = path.join(ROOT, 'uploads');
const PRODUCTS_FILE = path.join(DATA_DIR, 'products.json');
const BANNERS_FILE = path.join(DATA_DIR, 'banners.json');
const COFFEE_CARDS_FILE = path.join(DATA_DIR, 'coffee_cards.json');

// Web 管理员账号（可自行修改）
const ADMIN_USERS = {
  'admin': 'brew2024',
  'boss': 'brew2024',
};

// ==================== 工具函数 ====================

function uuid() { return crypto.randomUUID(); }

function readJSON(fp) {
  try { return JSON.parse(fs.readFileSync(fp, 'utf-8')); }
  catch { return null; }
}

function writeJSON(fp, data) {
  fs.writeFileSync(fp, JSON.stringify(data, null, 2), 'utf-8');
}

function getBody(req) {
  return new Promise((resolve) => {
    let body = '';
    req.on('data', (c) => (body += c));
    req.on('end', () => {
      try { resolve(JSON.parse(body)); }
      catch { resolve({}); }
    });
  });
}

function sha256(s) {
  return crypto.createHash('sha256').update(s).digest('hex');
}

// ==================== 初始化数据 ====================

function initData() {
  if (!fs.existsSync(DATA_DIR)) fs.mkdirSync(DATA_DIR, { recursive: true });
  if (!fs.existsSync(UPLOADS_DIR)) fs.mkdirSync(UPLOADS_DIR, { recursive: true });

  if (!readJSON(PRODUCTS_FILE)) writeJSON(PRODUCTS_FILE, [
    { id: '1', name: '肯尼亚 AA', price: '¥68', category: '非洲', origin: '肯尼亚', roast: '浅烘', image: '', desc: '明亮的黑醋栗与柑橘风味' },
    { id: '2', name: '埃塞俄比亚 耶加雪菲', price: '¥78', category: '非洲', origin: '埃塞俄比亚', roast: '浅烘', image: '', desc: '茉莉花香与柠檬酸质' },
    { id: '3', name: '哥伦比亚 蕙兰', price: '¥65', category: '南美', origin: '哥伦比亚', roast: '中烘', image: '', desc: '焦糖甜感与坚果香气' },
    { id: '4', name: '巴西 喜拉多', price: '¥55', category: '南美', origin: '巴西', roast: '中烘', image: '', desc: '柔和顺滑，经典风味' },
    { id: '5', name: '危地马拉 安提瓜', price: '¥72', category: '中美', origin: '危地马拉', roast: '中深烘', image: '', desc: '浓郁巧克力风味' },
    { id: '6', name: '哥斯达黎加 塔拉珠', price: '¥85', category: '中美', origin: '哥斯达黎加', roast: '中烘', image: '', desc: '蜂蜜甜感与热带水果' },
    { id: '7', name: '云南 小粒咖啡', price: '¥48', category: '亚洲', origin: '中国云南', roast: '中深烘', image: '', desc: '国货精品，红糖甜香' },
    { id: '8', name: '印度尼西亚 曼特宁', price: '¥69', category: '亚洲', origin: '苏门答腊', roast: '深烘', image: '', desc: '草本醇香与黑巧克力' },
    { id: '9', name: '秘鲁 禅茶玛悠', price: '¥62', category: '南美', origin: '秘鲁', roast: '中烘', image: '', desc: '干净明亮的酸甜平衡' },
    { id: '10', name: '卢旺达 基伍湖', price: '¥75', category: '非洲', origin: '卢旺达', roast: '浅烘', image: '', desc: '莓果风味，层次丰富' },
  ]);
  if (!readJSON(BANNERS_FILE)) writeJSON(BANNERS_FILE, [
    { id: '1', title: '手冲埃塞俄比亚', subtitle: '花香调 · 明亮果酸 · 柔顺口感', tag: '新品上市', image: '', gradient: ['#6B4423', '#3E2515'] },
    { id: '2', title: '冷萃哥伦比亚', subtitle: '巧克力风味 · 低酸度 · 醇厚顺滑', tag: '热卖推荐', image: '', gradient: ['#2C2420', '#1A1410'] },
    { id: '3', title: '单品意式拼配', subtitle: '坚果香 · 焦糖甜感 · 浓郁醇厚', tag: '限定特供', image: '', gradient: ['#5D4037', '#3E2723'] },
  ]);
  if (!readJSON(COFFEE_CARDS_FILE)) writeJSON(COFFEE_CARDS_FILE, [
    { id: '1', name: '肯尼亚 AA', desc: '明亮的黑醋栗与柑橘风味，层次分明，余韵悠长', origin: '非洲 · 肯尼亚', roast: '浅烘', image: '' },
    { id: '2', name: '埃塞俄比亚 耶加雪菲', desc: '茉莉花香与柠檬酸质，如花茶般清爽细腻', origin: '非洲 · 埃塞俄比亚', roast: '浅烘', image: '' },
    { id: '3', name: '哥伦比亚 蕙兰', desc: '焦糖甜感与坚果香气，醇厚平衡的经典之选', origin: '南美 · 哥伦比亚', roast: '中烘', image: '' },
    { id: '4', name: '云南 小粒咖啡', desc: '国货精品，红糖甜香与淡淡果韵，柔和不失个性', origin: '亚洲 · 中国云南', roast: '中深烘', image: '' },
    { id: '5', name: '印尼 曼特宁', desc: '草本醇香与黑巧克力尾韵，口感厚重顺滑', origin: '亚洲 · 苏门答腊', roast: '深烘', image: '' },
    { id: '6', name: '哥斯达黎加 塔拉珠', desc: '蜂蜜甜感与热带水果风味，干净明亮的回甘', origin: '中美 · 哥斯达黎加', roast: '中烘', image: '' },
  ]);
}

initData();

// ==================== 响应辅助 ====================

const MIME = {
  '.jpg': 'image/jpeg', '.jpeg': 'image/jpeg', '.png': 'image/png',
  '.gif': 'image/gif', '.webp': 'image/webp', '.ico': 'image/x-icon',
};

function send(res, code, ct, data) {
  const headers = { 'Access-Control-Allow-Origin': '*' };
  if (ct) headers['Content-Type'] = ct;
  res.writeHead(code, headers);
  res.end(data);
}

function json(res, data, code = 200) {
  send(res, code, 'application/json; charset=utf-8', JSON.stringify(data));
}

function html(res, data) {
  send(res, 200, 'text/html; charset=utf-8', data);
}

// ==================== API 认证 ====================

function checkAuth(req) {
  const auth = req.headers['authorization'] || '';
  const token = auth.replace('Bearer ', '');
  if (!token) return false;
  // token = sha256(username:password)
  for (const [u, p] of Object.entries(ADMIN_USERS)) {
    if (sha256(`${u}:${p}`) === token) return true;
  }
  return false;
}

function requireAuth(req, res) {
  if (!checkAuth(req)) { json(res, { error: '未授权，请先登录' }, 401); return false; }
  return true;
}

// ==================== Web 管理页面 ====================

const ADMIN_HTML = `
<!DOCTYPE html>
<html lang="zh-CN">
<head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Brew 管理后台</title>
<style>
* { margin: 0; padding: 0; box-sizing: border-box; }
body { font-family: -apple-system, sans-serif; background: #FFFBF7; color: #2A2520; }
.login-page { display:flex; align-items:center; justify-content:center; height:100vh; }
.login-box { background:#fff; padding:40px; border-radius:16px; box-shadow:0 2px 20px rgba(0,0,0,0.08); width:360px; }
.login-box h1 { text-align:center; margin-bottom:8px; font-size:28px; }
.login-box p { text-align:center; color:#8A7D75; margin-bottom:24px; font-size:14px; }
.login-box input { width:100%; padding:12px 16px; border:1px solid #D4CCC4; border-radius:8px; font-size:15px; margin-bottom:12px; outline:none; }
.login-box input:focus { border-color:#6B4423; }
.login-box button { width:100%; padding:12px; background:#6B4423; color:#fff; border:none; border-radius:24px; font-size:15px; cursor:pointer; font-weight:600; }
.login-box button:hover { background:#4A2F19; }
.error { color:#D32F2F; font-size:13px; text-align:center; margin-top:8px; }
.header { background:#2C2420; color:#FFFBF7; padding:12px 24px; display:flex; justify-content:space-between; align-items:center; }
.header h1 { font-size:17px; font-weight:600; }
.header button { background:transparent; color:#B8ADA5; border:1px solid #B8ADA5; padding:6px 16px; border-radius:16px; cursor:pointer; font-size:13px; }
.header button:hover { color:#fff; border-color:#fff; }
.nav { display:flex; gap:0; background:#fff; border-bottom:1px solid #E8E1DB; padding:0 24px; }
.nav button { padding:12px 20px; background:none; border:none; font-size:14px; cursor:pointer; color:#8A7D75; border-bottom:2px solid transparent; font-weight:500; }
.nav button.active { color:#6B4423; border-bottom-color:#6B4423; font-weight:600; }
.content { padding:24px; max-width:1000px; margin:0 auto; }
.card { background:#fff; border:1px solid #E8E1DB; border-radius:12px; padding:16px; margin-bottom:12px; display:flex; align-items:center; gap:12px; }
.card img { width:64px; height:64px; border-radius:6px; object-fit:cover; background:#F5F1EB; }
.card-info { flex:1; min-width:0; }
.card-info h3 { font-size:15px; margin-bottom:2px; }
.card-info p { font-size:12px; color:#8A7D75; }
.card-actions { display:flex; gap:8px; }
.card-actions button { padding:4px 12px; border-radius:6px; border:1px solid #D4CCC4; cursor:pointer; font-size:12px; background:#fff; }
.card-actions .edit { color:#6B4423; border-color:#6B4423; }
.card-actions .del { color:#D32F2F; border-color:#D32F2F; }
.add-btn { width:100%; padding:12px; background:#6B4423; color:#fff; border:none; border-radius:24px; font-size:14px; cursor:pointer; font-weight:600; margin-bottom:16px; }
.add-btn:hover { background:#4A2F19; }
.modal-overlay { position:fixed; top:0;left:0;right:0;bottom:0; background:rgba(0,0,0,0.4); display:flex; align-items:center; justify-content:center; z-index:100; }
.modal { background:#fff; border-radius:16px; padding:24px; width:420px; max-width:90vw; max-height:80vh; overflow-y:auto; }
.modal h2 { font-size:17px; margin-bottom:16px; }
.modal label { font-size:12px; color:#8A7D75; display:block; margin-bottom:4px; margin-top:12px; }
.modal input, .modal textarea { width:100%; padding:10px 12px; border:1px solid #D4CCC4; border-radius:8px; font-size:14px; outline:none; }
.modal input:focus, .modal textarea:focus { border-color:#6B4423; }
.modal textarea { resize:vertical; min-height:60px; }
.modal-preview { margin:12px 0; }
.modal-preview img { max-width:200px; max-height:120px; border-radius:8px; background:#F5F1EB; }
.modal-actions { display:flex; justify-content:flex-end; gap:12px; margin-top:20px; }
.modal-actions button { padding:8px 20px; border-radius:20px; border:none; cursor:pointer; font-size:14px; }
.modal-actions .cancel { background:#F5F1EB; color:#8A7D75; }
.modal-actions .save { background:#6B4423; color:#fff; font-weight:600; }
.modal-actions .save:hover { background:#4A2F19; }
.upload-btn { display:inline-flex; align-items:center; gap:6px; padding:8px 16px; background:#F5F1EB; border:1px dashed #D4CCC4; border-radius:8px; cursor:pointer; font-size:13px; color:#8A7D75; margin-top:8px; }
.upload-btn:hover { border-color:#6B4423; color:#6B4423; }
.toast { position:fixed; bottom:24px; left:50%; transform:translateX(-50%); background:#2C2420; color:#fff; padding:12px 24px; border-radius:24px; font-size:14px; z-index:200; animation:fadeIn 0.3s; }
@keyframes fadeIn { from{opacity:0;transform:translateX(-50%) translateY(20px)} to{opacity:1;transform:translateX(-50%) translateY(0)} }
.empty { text-align:center; color:#8A7D75; padding:60px 0; font-size:15px; }
body.admin { padding-bottom:40px; }
</style>
</head><body>
<div id="app"></div>
<script>
const BASE = window.location.origin;
let token = localStorage.getItem('brew_admin_token') || '';
let tab = 'products';

function api(method, path, data) {
  const opts = { method, headers: {} };
  if (token) opts.headers['Authorization'] = 'Bearer ' + token;
  if (data) { opts.headers['Content-Type'] = 'application/json'; opts.body = JSON.stringify(data); }
  return fetch(BASE + path, opts).then(r => r.json());
}

function toast(msg) {
  const t = document.createElement('div'); t.className='toast'; t.textContent=msg;
  document.body.appendChild(t); setTimeout(() => t.remove(), 2000);
}

function renderLogin() {
  document.getElementById('app').innerHTML = \`
    <div class="login-page"><div class="login-box">
      <h1>☕ Brew</h1><p>管理后台 · 请先登录</p>
      <input id="user" placeholder="用户名" autocomplete="username">
      <input id="pwd" type="password" placeholder="密码" autocomplete="current-password">
      <button onclick="login()">登录</button>
      <div class="error" id="err"></div>
    </div></div>
  \`;
  document.getElementById('pwd').addEventListener('keydown', e => { if (e.key==='Enter') login(); });
}

async function login() {
  const u = document.getElementById('user').value, p = document.getElementById('pwd').value;
  if (!u || !p) { document.getElementById('err').textContent = '请输入用户名和密码'; return; }
  const t = await sha256(u+':'+p);
  const res = await api('POST', '/api/admin/login', { token: t, user: u, pass: p });
  if (res.ok) { token = t; localStorage.setItem('brew_admin_token', t); renderAdmin(); }
  else { document.getElementById('err').textContent = res.error || '登录失败'; }
}

function logout() { token = ''; localStorage.removeItem('brew_admin_token'); renderLogin(); }

async function sha256(s) {
  const e = new TextEncoder().encode(s);
  const b = await crypto.subtle.digest('SHA-256', e);
  return Array.from(new Uint8Array(b)).map(v => v.toString(16).padStart(2,'0')).join('');
}

async function renderAdmin() {
  const [products, banners, cards] = await Promise.all([
    api('GET', '/api/products'), api('GET', '/api/banners'), api('GET', '/api/coffee-cards')
  ]);
  if (products.error) { renderLogin(); return; }

  const tabs = ['products','banners','cards'];
  const labels = { products:'产品管理', banners:'轮播管理', cards:'咖啡卡片' };

  function renderList(items, type) {
    if (!items || items.length===0) return '<div class="empty">暂无数据</div>';
    return items.map(item => {
      const img = item.image ? BASE+'/uploads/'+item.image : '';
      const sub = type==='products' ? \`\${item.price} · \${item.category} · \${item.roast}\`
        : type==='banners' ? \`\${item.tag} · \${item.subtitle}\`
        : \`\${item.origin} · \${item.roast}\`;
      return \`<div class="card">
        <img src="\${img}" alt="">
        <div class="card-info"><h3>\${item.title||item.name}</h3><p>\${sub}</p></div>
        <div class="card-actions">
          <button class="edit" onclick='edit("\${type}","\${item.id}")'>编辑</button>
          \${type==='products' ? '<button class="del" onclick="del(\\''+type+'\\',\\''+item.id+'\\')">删除</button>' : ''}
        </div>
      </div>\`;
    }).join('');
  }

  document.getElementById('app').innerHTML = \`
    <div class="admin">
      <div class="header"><h1>☕ Brew 管理后台</h1><button onclick="logout()">退出登录</button></div>
      <div class="nav">\${tabs.map(t => '<button class="'+(tab===t?'active':'')+'" onclick="switchTab(\\''+t+'\\')">'+labels[t]+'</button>').join('')}</div>
      <div class="content" id="content"></div>
    </div>
  \`;
  renderTabContent();
}

function switchTab(t) { tab = t; renderTabContent(); }

function renderTabContent() {
  api('GET', '/api/'+tab).then(items => {
    const label = { products:'产品管理', banners:'轮播管理', cards:'咖啡卡片' };
    let html = \`<button class="add-btn" onclick='add("'+tab+'")'>+ 添加\${tab==='products'?'产品':tab==='banners'?'轮播':'卡片'}</button>\`;
    const list = Array.isArray(items) ? items : [];
    html += renderList(list, tab);
    document.getElementById('content').innerHTML = html;
  });
}

function add(type) {
  if (type==='banners') { showBannerForm(null); return; }
  if (type==='cards') { showCardForm(null); return; }
  showProductForm(null);
}

function edit(type, id) {
  api('GET', '/api/'+type+'/'+id).then(item => {
    if (type==='products') showProductForm(item);
    else if (type==='banners') showBannerForm(item);
    else showCardForm(item);
  });
}

function del(type, id) {
  if (!confirm('确认删除？')) return;
  api('DELETE', '/api/'+type+'/'+id).then(() => { toast('已删除'); renderTabContent(); });
}

// ---- 产品表单 ----
function showProductForm(item) {
  const isNew = !item;
  const m = document.createElement('div'); m.className='modal-overlay'; m.innerHTML=\`
    <div class="modal"><h2>\${isNew?'添加产品':'编辑产品'}</h2>
      <label>名称</label><input id="f_name" value="\${item?.name||''}">
      <label>价格</label><input id="f_price" value="\${item?.price||''}">
      <label>分类</label><input id="f_category" value="\${item?.category||''}">
      <label>产地</label><input id="f_origin" value="\${item?.origin||''}">
      <label>烘焙度</label><input id="f_roast" value="\${item?.roast||''}">
      <label>描述</label><textarea id="f_desc">\${item?.desc||''}</textarea>
      <label>图片</label>
      \${item?.image ? '<div class="modal-preview"><img src="'+BASE+'/uploads/'+item.image+'"></div>' : ''}
      <div class="upload-btn" onclick="document.getElementById('f_img_input').click()">📷 选择图片</div>
      <input id="f_img_input" type="file" accept="image/*" style="display:none" onchange="uploadImg(this,'f_img_preview','f_img')">
      <input id="f_img" type="hidden" value="\${item?.image||''}">
      <div id="f_img_preview"></div>
      <div class="modal-actions">
        <button class="cancel" onclick="this.closest('.modal-overlay').remove()">取消</button>
        <button class="save" onclick="saveProduct('\${item?.id||''}',this)">保存</button>
      </div>
    </div>\`;
  document.body.appendChild(m);
  m.addEventListener('click', e => { if (e.target===m) m.remove(); });
}

async function saveProduct(id, btn) {
  btn.textContent='保存中...'; btn.disabled=true;
  const data = {
    name: document.getElementById('f_name').value,
    price: document.getElementById('f_price').value,
    category: document.getElementById('f_category').value,
    origin: document.getElementById('f_origin').value,
    roast: document.getElementById('f_roast').value,
    desc: document.getElementById('f_desc').value,
    image: document.getElementById('f_img').value,
  };
  const res = id ? await api('PUT', '/api/products/'+id, data) : await api('POST', '/api/products', data);
  btn.closest('.modal-overlay').remove();
  toast(id?'已更新':'已添加');
  renderTabContent();
}

// ---- Banner 表单 ----
function showBannerForm(item) {
  const isNew = !item;
  const m = document.createElement('div'); m.className='modal-overlay'; m.innerHTML=\`
    <div class="modal"><h2>\${isNew?'添加轮播':'编辑轮播'}</h2>
      <label>标题</label><input id="f_title" value="\${item?.title||''}">
      <label>副标题</label><textarea id="f_subtitle">\${item?.subtitle||''}</textarea>
      <label>标签</label><input id="f_tag" value="\${item?.tag||''}">
      <label>图片</label>
      \${item?.image ? '<div class="modal-preview"><img src="'+BASE+'/uploads/'+item.image+'"></div>' : ''}
      <div class="upload-btn" onclick="document.getElementById('f_img_input2').click()">📷 选择图片</div>
      <input id="f_img_input2" type="file" accept="image/*" style="display:none" onchange="uploadImg(this,'f_img_preview2','f_img2')">
      <input id="f_img2" type="hidden" value="\${item?.image||''}">
      <div id="f_img_preview2"></div>
      <div class="modal-actions">
        <button class="cancel" onclick="this.closest('.modal-overlay').remove()">取消</button>
        <button class="save" onclick="saveBanner('\${item?.id||''}',this)">保存</button>
      </div>
    </div>\`;
  document.body.appendChild(m);
  m.addEventListener('click', e => { if (e.target===m) m.remove(); });
}

async function saveBanner(id, btn) {
  btn.textContent='保存中...'; btn.disabled=true;
  const data = {
    title: document.getElementById('f_title').value,
    subtitle: document.getElementById('f_subtitle').value,
    tag: document.getElementById('f_tag').value,
    image: document.getElementById('f_img2').value,
  };
  await api('PUT', '/api/banners/'+id, data);
  btn.closest('.modal-overlay').remove();
  toast('已更新');
  renderTabContent();
}

// ---- 卡片表单 ----
function showCardForm(item) {
  const isNew = !item;
  const m = document.createElement('div'); m.className='modal-overlay'; m.innerHTML=\`
    <div class="modal"><h2>\${isNew?'添加卡片':'编辑咖啡卡片'}</h2>
      <label>名称</label><input id="f_cname" value="\${item?.name||''}">
      <label>描述</label><textarea id="f_cdesc">\${item?.desc||''}</textarea>
      <label>产地</label><input id="f_origin2" value="\${item?.origin||''}">
      <label>烘焙度</label><input id="f_roast2" value="\${item?.roast||''}">
      <label>图片</label>
      \${item?.image ? '<div class="modal-preview"><img src="'+BASE+'/uploads/'+item.image+'"></div>' : ''}
      <div class="upload-btn" onclick="document.getElementById('f_img_input3').click()">📷 选择图片</div>
      <input id="f_img_input3" type="file" accept="image/*" style="display:none" onchange="uploadImg(this,'f_img_preview3','f_img3')">
      <input id="f_img3" type="hidden" value="\${item?.image||''}">
      <div id="f_img_preview3"></div>
      <div class="modal-actions">
        <button class="cancel" onclick="this.closest('.modal-overlay').remove()">取消</button>
        <button class="save" onclick="saveCard('\${item?.id||''}',this)">保存</button>
      </div>
    </div>\`;
  document.body.appendChild(m);
  m.addEventListener('click', e => { if (e.target===m) m.remove(); });
}

async function saveCard(id, btn) {
  btn.textContent='保存中...'; btn.disabled=true;
  const data = {
    name: document.getElementById('f_cname').value,
    desc: document.getElementById('f_cdesc').value,
    origin: document.getElementById('f_origin2').value,
    roast: document.getElementById('f_roast2').value,
    image: document.getElementById('f_img3').value,
  };
  await api('PUT', '/api/coffee-cards/'+id, data);
  btn.closest('.modal-overlay').remove();
  toast('已更新');
  renderTabContent();
}

// ---- 图片上传 ----
async function uploadImg(input, previewId, hiddenId) {
  const file = input.files[0]; if (!file) return;
  const reader = new FileReader();
  reader.onload = async function(e) {
    const base64 = e.target.result;
    const res = await api('POST', '/api/upload', { image: base64 });
    if (res.filename) {
      document.getElementById(hiddenId).value = res.filename;
      document.getElementById(previewId).innerHTML = '<div class="modal-preview"><img src="'+BASE+'/uploads/'+res.filename+'"></div>';
      toast('图片已上传');
    }
  };
  reader.readAsDataURL(file);
}

// ---- 启动 ----
if (token) { renderAdmin(); } else { renderLogin(); }
</script>
</body></html>
`;

initData();

// ==================== HTTP 服务器 ====================

const server = http.createServer(async (req, res) => {
  const method = req.method;
  const p = req.url.split('?')[0];

  // CORS 预检
  if (method === 'OPTIONS') {
    res.writeHead(204, {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET,POST,PUT,DELETE,OPTIONS',
      'Access-Control-Allow-Headers': 'Content-Type,Authorization',
    });
    return res.end();
  }

  // ---- 静态文件：uploads 目录 ----
  if (method === 'GET' && p.startsWith('/uploads/')) {
    const fp = path.join(ROOT, p);
    const ext = path.extname(fp).toLowerCase();
    if (fs.existsSync(fp)) {
      return send(res, 200, MIME[ext] || 'application/octet-stream', fs.readFileSync(fp));
    }
    return send(res, 404, 'text/plain', 'Not Found');
  }

  // ---- 管理后台页面 ----
  if (method === 'GET' && p === '/admin') {
    return html(res, ADMIN_HTML);
  }

  // ---- 管理员登录 ----
  if (method === 'POST' && p === '/api/admin/login') {
    const body = await getBody(req);
    if (ADMIN_USERS[body.user] && ADMIN_USERS[body.user] === body.pass) {
      const expectedToken = sha256(`${body.user}:${body.pass}`);
      return json(res, { ok: true, token: expectedToken });
    }
    return json(res, { ok: false, error: '用户名或密码错误' }, 401);
  }

  // ---- 以下 API 需要认证 ----
  if (p.startsWith('/api/')) {
    if (!requireAuth(req, res)) return;
  }

  // ---- 产品 API ----
  if (method === 'GET' && p === '/api/products') return json(res, readJSON(PRODUCTS_FILE) || []);
  if (method === 'POST' && p === '/api/products') {
    const body = await getBody(req);
    const list = readJSON(PRODUCTS_FILE) || [];
    const item = { id: uuid(), name: body.name || '', price: body.price || '', category: body.category || '', origin: body.origin || '', roast: body.roast || '', image: body.image || '', desc: body.desc || '' };
    list.push(item); writeJSON(PRODUCTS_FILE, list);
    return json(res, item, 201);
  }
  const prodMatch = p.match(/^\/api\/products\/([^/]+)$/);
  if (prodMatch) {
    const id = prodMatch[1];
    const list = readJSON(PRODUCTS_FILE) || [];
    const idx = list.findIndex(x => x.id === id);
    if (idx === -1) return json(res, { error: '不存在' }, 404);
    if (method === 'GET') return json(res, list[idx]);
    if (method === 'PUT') {
      const body = await getBody(req);
      ['name','price','category','origin','roast','image','desc'].forEach(f => { if (body[f] !== undefined) list[idx][f] = body[f]; });
      writeJSON(PRODUCTS_FILE, list);
      return json(res, list[idx]);
    }
    if (method === 'DELETE') {
      const del = list.splice(idx, 1)[0]; writeJSON(PRODUCTS_FILE, list);
      return json(res, del);
    }
  }

  // ---- Banner API ----
  if (method === 'GET' && p === '/api/banners') return json(res, readJSON(BANNERS_FILE) || []);
  const banMatch = p.match(/^\/api\/banners\/([^/]+)$/);
  if (banMatch) {
    const id = banMatch[1];
    const list = readJSON(BANNERS_FILE) || [];
    const idx = list.findIndex(x => x.id === id);
    if (idx === -1) return json(res, { error: '不存在' }, 404);
    if (method === 'GET') return json(res, list[idx]);
    if (method === 'PUT') {
      const body = await getBody(req);
      ['title','subtitle','tag','image','gradient'].forEach(f => { if (body[f] !== undefined) list[idx][f] = body[f]; });
      writeJSON(BANNERS_FILE, list);
      return json(res, list[idx]);
    }
  }

  // ---- 咖啡卡片 API ----
  if (method === 'GET' && p === '/api/coffee-cards') return json(res, readJSON(COFFEE_CARDS_FILE) || []);
  const cardMatch = p.match(/^\/api\/coffee-cards\/([^/]+)$/);
  if (cardMatch) {
    const id = cardMatch[1];
    const list = readJSON(COFFEE_CARDS_FILE) || [];
    const idx = list.findIndex(x => x.id === id);
    if (idx === -1) return json(res, { error: '不存在' }, 404);
    if (method === 'GET') return json(res, list[idx]);
    if (method === 'PUT') {
      const body = await getBody(req);
      ['name','desc','origin','roast','image'].forEach(f => { if (body[f] !== undefined) list[idx][f] = body[f]; });
      writeJSON(COFFEE_CARDS_FILE, list);
      return json(res, list[idx]);
    }
  }

  // ---- 图片上传 ----
  if (method === 'POST' && p === '/api/upload') {
    const body = await getBody(req);
    if (!body.image) return json(res, { error: '缺少 image' }, 400);
    const m = body.image.match(/^data:image\/(\w+);base64,(.+)$/);
    if (!m) return json(res, { error: '无效图片格式' }, 400);
    const ext = m[1] === 'jpeg' ? 'jpg' : m[1];
    const filename = `${uuid()}.${ext}`;
    fs.writeFileSync(path.join(UPLOADS_DIR, filename), Buffer.from(m[2], 'base64'));
    return json(res, { filename }, 201);
  }

  json(res, { error: 'Not Found' }, 404);
});

server.listen(PORT, '0.0.0.0', () => {
  console.log(`✅ Brew Web 管理后台: http://localhost:${PORT}/admin`);
  console.log(`数据目录: ${DATA_DIR}`);
  console.log(`图片目录: ${UPLOADS_DIR}`);
  console.log(`管理员账号: ${Object.keys(ADMIN_USERS).join(', ')}`);
});
