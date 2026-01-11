# Troubleshooting Blank Screen in Flutter Web

## Common Causes

### 1. Backend Not Running
The app tries to check authentication status on startup. If the backend isn't running, it may show a blank screen.

**Solution:**
```bash
# Start backend services
docker-compose up -d

# Verify backend is running
curl http://localhost:8000/health
```

### 2. CORS Issues (Web Browser)
Flutter web requires CORS headers from the backend.

**Check:** Open browser DevTools (F12) → Console tab → Look for CORS errors

**Solution:** The backend CORS is configured, but ensure `DEBUG=True` in `.env`

### 3. API Connection Error
The app might be failing silently when trying to connect to the API.

**Check:** 
- Open browser DevTools (F12) → Console tab
- Look for network errors or JavaScript errors
- Check Network tab for failed API calls

### 4. Check Browser Console
1. Open Chrome DevTools (F12 or Cmd+Option+I)
2. Go to Console tab
3. Look for red error messages
4. Go to Network tab
5. Refresh the page
6. Check if API calls are failing

## Quick Fixes

### Option 1: Start Backend First
```bash
# Terminal 1: Start backend
docker-compose up -d

# Wait for services to be ready
sleep 10

# Terminal 2: Run Flutter
cd flutter_app
flutter run -d chrome
```

### Option 2: Check for Errors
1. Run Flutter with verbose logging:
```bash
flutter run -d chrome --verbose
```

2. Check browser console for errors

### Option 3: Test API Connection
```bash
# Test if backend is accessible
curl http://localhost:8000/health

# Should return: {"status":"healthy"}
```

### Option 4: Use Different Port
Sometimes port conflicts cause issues:
```bash
flutter run -d chrome --web-port=8080
```

## Debugging Steps

1. **Check Backend Status:**
   ```bash
   docker-compose ps
   docker-compose logs api
   ```

2. **Check Flutter Logs:**
   ```bash
   flutter run -d chrome --verbose
   ```

3. **Check Browser Console:**
   - Open DevTools (F12)
   - Check Console for errors
   - Check Network tab for failed requests

4. **Verify API Endpoint:**
   - The app uses `http://localhost:8000` by default
   - For web, this should work
   - If using a different host, update `api_constants.dart`

## Expected Behavior

1. App starts → Shows "VocabMaster" loading screen
2. Checks auth status → Calls `/api/user/profile`
3. If no token → Navigates to login screen
4. If token exists → Validates and navigates to home

If any step fails, check the browser console for the specific error.
