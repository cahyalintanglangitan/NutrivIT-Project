import requests
import json

# Membaca API key dari file api_key.txt
try:
    api_key = open("api_key.txt").read().strip()
except FileNotFoundError:
    print("Error: File 'api_key.txt' tidak ditemukan. Pastikan file tersebut ada di folder yang sama.")
    exit()

# Menggunakan nama model yang benar: gemini-1.5-flash-latest
model_name = "gemini-1.5-flash-latest"
endpoint = f"https://generativelanguage.googleapis.com/v1beta/models/{model_name}:generateContent?key={api_key}"

headers = {
    "Content-Type": "application/json"
}

data = {
    "contents": [{
        "parts": [{
            "text": "jelaskan apa itu AI?"
        }]
    }]
}

try:
    response = requests.post(endpoint, headers=headers, json=data)
    response.raise_for_status()  # Ini akan menampilkan error jika status code bukan 2xx

    response_data = response.json()
    
    # Mengakses respons dengan kunci yang benar: 'candidates'
    gemini_response = response_data['candidates'][0]['content']['parts'][0]['text']
    print("Respon Gemini:\n", gemini_response)

except requests.exceptions.HTTPError as err:
    print(f"HTTP Error: {err}")
    # Mencetak detail error dari respons API jika ada
    try:
        error_details = response.json()
        print("API Error Details:", json.dumps(error_details, indent=2))
    except json.JSONDecodeError:
        print("Could not parse error response.")
except Exception as e:
    print(f"An unexpected error occurred: {e}")